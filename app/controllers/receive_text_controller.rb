class ReceiveTextController < ApplicationController

  def receiver     
    message_body = params["Body"]
    from_number = params["From"]

    if message_body && from_number
    	IncomingText.create(:from => from_number, :body => message_body)
    	station = Station.find_by_name(message_body)
    	Sender.send(from_number[2..-1], station.line_1)
    end
  end
end
