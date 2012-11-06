require 'spec_helper'

describe Message do
  describe "on initialize" do
    it "sets the station" do
      Message.any_instance.should_receive :setup_station
      Message.new
    end
  end

  describe ".create_from_params" do
    it "creates a message" do
      Message.create_from_params({}).should be_kind_of(Message)
    end

    it "sets the body attribute" do
      Message.create_from_params({"Body" => "the body"}).body.should == "the body"
    end

    it "sets the from attribute" do
      Message.create_from_params({"From" => "the from"}).from.should == "the from"
    end
  end

  describe "model attributes" do
    let(:message){ Message.new(:body => "The Body", :from => "The From")}

    it "is valid with valid attributes" do
      message.should be_valid
    end

    it "is not valid without a body" do
      message.body = nil
      message.should_not be_valid
    end

    it "is not valid without a from" do
      message.from = nil
      message.should_not be_valid
    end
  end

  describe "#process" do
    let(:station){ Station.create(:name => "Metro Center")}
    let(:message){ Message.create(:body => station.name, :from => "2223334444") }

    it "sends the response" do
      Response.any_instance.should_receive :transmit
      message.process
    end
  end
end