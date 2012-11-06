class MessagesController < ApplicationController
  def create
    Message.create_from_params(params)
    render :status => 200
  end
end