class Station < ActiveRecord::Base
  attr_accessible :code,:lat, :lon, :line_1, :line_2, :line_3, :line_4, :name, :station_together1, :station_together2 

  include ApplicationHelper

  include HTTParty
  format :json

  def fetch_times
	response = HTTParty.get("http://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{self.code}", :query => { :api_key => $wmata_key })
  	response.parsed_response['Trains']
  end

  def train_times
    max_arrivals = 3
  	arrivals     = []

  	fetch_times.each do |train|
  		line     = train["Line"]
      dest     = train["DestinationName"]
  		arriving = train["Min"]

      arrival = train_arrival(line, dest, arriving)
  		arrivals << arrival if arrival

      break if arrivals.size == max_arrivals
  	end
  	if arrivals.empty?
      "Don't think there are any metros coming dude. Bikeshare?"
    else
      arrivals.join(", ")
    end
  end

  def self.match(input)
    station = where(Station.arel_table[:name].matches("%#{sanitize_name(input)}%")).first
    station ||= Station.nickname_match(input)
  end

  def self.nickname_match(input)
    if ["Chinatown/Gallery Place", "Chinatown"].any?{|name| name.downcase == input.downcase}
      Station.find_by_name("Gallery Place")
    elsif ["MVT", "Mt. Vernon Triangle", "Mt. Vernon Sq", "Mount Vernon Square"].any?{|name| name.downcase == input.downcase}
      Station.find_by_name("Mt Vernon Sq")
    elsif ["Dupont"].any?{|name| name.downcase == input.downcase}
      Station.find_by_name("Dupont Circle")
    elsif ["West Falls Church"].any?{|name| name.downcase == input.downcase}
      Station.find_by_name("W Falls Church")
    elsif ["U st", "THE U"].any?{|name| name.downcase == input.downcase}
      Station.find_by_name("U Street")
    end
  end

private
  
  def train_arrival(line, dest, arriving)
    valid = true

    arrive = case arriving
      when "BRD" then "BOARDING"
      when "ARR" then "ARRIVING"
      else "in #{arriving} min"
    end

    valid = false if ["--","No", ""].include? line
    valid = false if ["", " ", "No Passenger"].include? dest
    valid = false if [""].include? arriving

    "#{line} to #{dest} #{arrive}" if valid
  end

  def sanitize_name(input)
    input.downcase.gsub(".","")
  end
end





