class Station < ActiveRecord::Base
  attr_accessible :code,:lat, :lon, :line_1, :line_2, :line_3, :line_4, :name, :station_together1, :station_together2 

  include HTTParty
  format :json

  def fetch_times
	response = HTTParty.get("http://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{self.code}", :query => {:api_key => "rpefka927ws7cy228jsrejx7"})
  	response.parsed_response['Trains']
  end

  def response_train_times
  	response = ""
  	fetch_times[0..2].each do |train|
  		dest     = train["DestinationName"]
  		line     = train["Line"]
  		arriving = train["Min"]

  		if arriving == "BRD"
  			arrive = "BOARDING"
  		elsif arriving == "ARR"
  			arrive == "ARRIVING"
  		else
  			arrive = "in #{arriving} min"
  		end

  		response <<"#{line} to #{dest} #{arrive}, "
  	end
  	response
  end

end
