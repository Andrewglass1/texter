module ApplicationHelper
  def train_arrival(line, dest, arriving)
    valid = true

    arrive = case arriving
      when "BRD" then "BOARDING"
      when "ARR" then "ARRIVING"
      else "in #{arriving} min"
    end

    valid = false if ["==","No", ""].include? line
    valid = false if ["", " ", "No Passenger"].include? dest
    valid = false if [""].include? arriving

    "#{line} to #{dest} #{arrive}" if valid
  end
end
