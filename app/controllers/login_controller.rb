require 'net/http'
require "uri"
class LoginController < ApplicationController
  def index
    @linen = true
  end
  def create
    uri = URI.parse('http://0.0.0.0:3000/api_session.json')
    
    @login = params[:login]
    @response = Net::HTTP.post_form(uri, {"login" => @login, "password" => params[:pass]})
    
    session[:api_token] = @response.body
    session[:user_login] = @login

    respond_to do |format|
      format.html # create.html.erb
      format.json { render json: @response.body }
    end
  end
  def show
    @show_header = true
    @show_right_side = true
    @show_left_side = false
  end
  def destroy
    uri = URI.parse('http://0.0.0.0:3000/api_session.json?auth_token=' + session[:api_token])
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Delete.new(uri.path)
    response = http.request(request)
  end
end
