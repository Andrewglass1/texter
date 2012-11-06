class Sender < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.send(number, content)

    twilio_sid = "AC93aea8b6a1786fdd69d19cc3eb36cf91"
    twilio_token = "443dbbdfd84e234b5b4daa23b6562039"
    twilio_phone_number = "5162791501"

    twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number,
      :body => content
    )
  end
end
