class MessagesController < ApplicationController
  before_filter :authenticate, :only => [:index]

  def create
    Message.create_from_params(params)
    render :status => 200
  end

  def index
    @messages = Message.all
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == $admin_un && password == $admin_pw
    end
  end
end