#path = File.join(Rails.root, "config/twilio.yml")
#TWILIO_CONFIG = YAML.load(File.read(path))[Rails.env] || {'sid' => '', 'from' => '', 'token' => ''}

twilio_sid = "AC93aea8b6a1786fdd69d19cc3eb36cf91"
twilio_token = "443dbbdfd84e234b5b4daa23b6562039"
$twilio_phone_number = "2028001876"

$twilio = Twilio::REST::Client.new twilio_sid, twilio_token

$admin_un = "metromike12345"
$admin_pw = "mikeymetro12345"