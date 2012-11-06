class Response < ActiveRecord::Base
  belongs_to :message

  after_initialize :set_to_and_body

  def transmit
    $twilio.account.sms.messages.create(
      :from => "+1#{$twilio_phone_number}",
      :to => to,
      :body => body
    )
  end


private
  def set_to_and_body
    self.to   = message.from
    
    if message.station
      self.body = message.station.train_times
    else
      self.body = "Sorry, couldn't match a metro station"
    end
  end
end
