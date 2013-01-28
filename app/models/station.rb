class Station < ActiveRecord::Base
  attr_accessible :code,:lat, :lon, :line_1, :line_2, :line_3, :line_4, :name, :station_together1, :station_together2 

  include ApplicationHelper

  include HTTParty
  format :json

  def fetch_times
    codes = [code, station_together1, station_together2].compact.join(",")
	  response = HTTParty.get("http://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{codes}", :query => { :api_key => $wmata_key })
    response.parsed_response['Trains']
  end

  def train_times
    max_arrivals = 4
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

  def nicknames
    case name
      when "Dupont Circle"     then ["dupont"]
      when "Gallery Place"     then ["Chinatown/Gallery Place", "Chinatown"]
      when "Mt Vernon Sq"      then ["MVT", "Mt. Vernon Triangle", "Mt. Vernon Sq", "Mount Vernon Square"]
      when "U Street"          then ["U st", "THE U"]
      when "W Falls Church"    then ["West Falls Church"]
      when "National Arpt"     then ['Reagan national airport', 'Reagan', 'airport', 'national airport']
      when "Virginia Square"   then ["Va square"]
      when "Van Ness UDC"      then ["Van Ness", "UDC"]
      when "Largo Town Center" then ["Largo"]
      when "Fort Totten"       then ["Ft Totten"]
      when "Federal Center SW" then ["Federal Center"]
      when "Woodley Park Zoo"  then ["Woodley", "Woodley Park", "Zoo", "Admo", "Adams Morgan"]
      when "New York Avenue"   then ["noma", "Gallaudet University", "Gallaudet U"]

      else []
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





