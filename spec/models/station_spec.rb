require 'spec_helper'

describe Station do 
  describe "#match" do
    before(:each) do
      Station.create(:name => "Metro Center")
    end

    it "finds the appropriate station listing" do
      Station.match("Metro Center").name.should == "Metro Center"
    end

    it "finds a case-insensitive-match station listing" do
      Station.match("metro center").name.should == "Metro Center"      
    end
  end
end