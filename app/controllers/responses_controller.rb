class ResponsesController < ApplicationController
  before_filter :authenticate, :only => [:index]

  def index
    @responses = Response.all
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == $admin_un && password == $admin_pw
    end
  end
end
