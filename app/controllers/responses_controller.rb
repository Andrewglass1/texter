class ResponsesController < ApplicationController
  def index
    @responses = Response.all
  end
end
