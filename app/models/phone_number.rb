class PhoneNumber
  def self.parse(input)
    input.gsub("+1","") if input
  end
end
