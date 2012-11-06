class ReceiveTextController < ApplicationController

  def receiver 
    # let's pretend that we've mapped this action to 
    # http://localhost:3000/sms in the routes.rb file
    
    message_body = params["Body"]
    from_number = params["From"]

    if message_body && from_number
    	IncomingText.create(:from => from_number, :body => message_body)
    end
    # SMSLogger.log_text_message from_number, message_body
  end
end
