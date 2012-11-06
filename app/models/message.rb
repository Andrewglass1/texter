class Message < ActiveRecord::Base
  attr_accessible :body, :from

  def self.create_from_params(params)
    message_body = params["Body"]
    from_number = params["From"]

    if message_body && from_number
      Message.create(:from => from_number, :body => message_body)
    end
  end

  def from=(input)
  	if input.start_with?("+1")
  	  @from = input[2..-1]
    else
      @from = input
  	end
  end

  def process
    station = Station.find_by_name(body)
    Sender.send(from, station.response_train_times)
  end
end
