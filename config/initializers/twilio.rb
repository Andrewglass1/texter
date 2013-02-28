twilio_sid = ENV['TWILIO_SID']
twilio_token = ENV['TWILIO_TOKEN']
$twilio_phone_number = ENV['TWILIO_NUMBER']

$twilio = Twilio::REST::Client.new twilio_sid, twilio_token

$admin_un = ENV['TEXTER_ADMIN_UN']
$admin_pw = ENV['TEXTER_ADMIN_PW']