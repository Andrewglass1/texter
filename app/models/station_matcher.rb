class StationMatcher

  require 'amatch'

  def initialize(input)
    @input = input

  end

  def match
    station = Station.all.detect{|station| fuzzy_match(station.name)}
    station ||= nickname_match
  end

  def nickname_match
    Station.all.detect {|station| station.nicknames.any?{|nn| fuzzy_match(nn)}}
  end

  def fuzzy_match(matching)
    m = Amatch::Jaro.new(@input)
    m.match(matching) > 0.8
  end

end