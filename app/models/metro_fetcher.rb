class MetroFetcher
  include HTTParty
  format :json

  def self.fetch_all_stations
    response = get('http://api.wmata.com/Rail.svc/json/JStations', :query => {:api_key => "rpefka927ws7cy228jsrejx7"})
    response.parsed_response['Stations'].each do |station|
    	Station.create(:code => station['Code'],
    				   :lat  => station['Lat'],
    				   :lon => station['Lon'],
    				   :line_1 => station['LineCode1'],
    				   :line_2 => station['LineCode2'],
    				   :line_3 => station['LineCode3'],
    				   :line_4 => station['LineCode4'],
    				   :name => station['Name'],
    				   :station_together1 => station['StationTogether1'],
    				   :station_together2 => station['StationTogether2']
    				   )
    end
  end
end