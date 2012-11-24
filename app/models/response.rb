class Response < ActiveRecord::Base
  belongs_to :message

  def transmit
    unless status == "sent"
      $twilio.account.sms.messages.create(
        :from => "+1#{$twilio_phone_number}",
        :to => to,
        :body => body
      )
      self.update_attribute(:status,"sent")
    end
  end



  def set_to_and_body
    self.to   = message.from
    if message.station
      self.body = message.station.train_times
    else
      self.body = "Sorry, couldn't match a metro station with #{message.body}"
    end
  end
end
