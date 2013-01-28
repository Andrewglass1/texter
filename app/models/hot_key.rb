class HotKey < ActiveRecord::Base
  attr_accessible :input, :phone_number, :station_id
  after_create :setter_response

  def setter_response
    response = Response.create(to: phone_number, body: Response.hot_key_set(input, station.name))
    response.transmit
  end

  def station
    Station.find(station_id)
  end

  def self.match_hotkey(phone_number, input)
    HotKey.where(:phone_number => phone_number, :input => input.downcase).first
  end
end
