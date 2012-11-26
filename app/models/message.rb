class Message < ActiveRecord::Base
  attr_accessible :body, :from
  validates :body, :from, :presence => true
  belongs_to :station
  has_many :responses

  after_create :parse_message

  def self.create_from_params(params)
    Message.create(:body => params["Body"], :from => PhoneNumber.parse(params["From"]))
  end

  def process
    response = self.responses.new
    response.set_to_and_body
    response.transmit
    response.save!
  end

private

  def parse_message
    if body.split(" ").first.downcase == "set"
      create_hot_key
    else
      setup_station
    end
  end

  def station_from_hot_key
    hot_key = HotKey.where(:phone_number => from, :input => body).first
    if hot_key.present? && hot_key.station_id.present?
      self.station = Station.find(hot_key.station_id)
      save!
    end
  end

  def station_from_body
    self.station = StationMatcher.new(body).match
    save!
  end

  def setup_station
    station_from_hot_key || station_from_body
    process
  end

  def create_hot_key
    station_text  = body.split(" to ")[1]
    hot_key_input = body.split(" to ")[0].gsub("set ", "").gsub("Set ", "")
    HotKey.create(input: hot_key_input, station_id: StationMatcher.new(station_text).match.id, phone_number: from)
  end

end
