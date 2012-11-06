require 'spec_helper'

describe Response do 
  describe "#transmit" do
    it "sends the response via the client"
  end

  describe ".new" do
    let(:station){ Station.create(:name => "Metro Center")}
    let(:message){ Message.create(:body => station.name, :from => "2223334444") }
    let(:response){ message.responses.new }

    it "sets up the response message" do
      response.body.should be
    end

    it "determines the receiver" do
      response.to.should be
    end
  end
end