class Message < ActiveRecord::Base
  attr_accessible :body, :from
  validates :body, :from, :presence => true
  belongs_to :station
  has_many :responses

  after_create :setup_station
  after_save   :process

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
  def setup_station
    if self.body
      self.station = StationMatcher.new(body).match
    end
  end
end
