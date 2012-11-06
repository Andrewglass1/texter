require 'spec_helper'

describe PhoneNumber do
  describe ".parse" do
    it "takes the +1 off of a number" do
      PhoneNumber.parse("+12022222222").should == "2022222222"
    end

    it "returns a 10 digit number unchanged" do
      PhoneNumber.parse("2022222222").should == "2022222222"
    end

    it "doesn't blow up when given nil" do
      expect{ PhoneNumber.parse(nil) }.to_not raise_error
    end
  end  
end