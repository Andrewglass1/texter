class Sender < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.send(number, content)
    $twilio.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number,
      :body => content
    )
  end
end
