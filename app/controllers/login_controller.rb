require 'net/http'
require "uri"
class LoginController < ApplicationController
  def index
    @linen = true
    
    if params[:errorlogin] == "true"
      @errorlogin = true
    else
      @errorlogin = false
    end
  end
  def create
    uri = URI.parse('http://0.0.0.0:3000/api_session.json')
    
    @login = params[:login]
    @response = Net::HTTP.post_form(uri, {"login" => @login, "password" => params[:pass]})
    if @response.body == "error"
      redirect_to :action => "index", :errorlogin => true
    else    
      session[:api_token] = @response.body
      session[:user_login] = @login

      respond_to do |format|
        format.html # create.html.erb
        format.json { render json: @response.body }
      end
    end
  end
  def show
    @show_header = true
    @show_right_side = true
    @show_left_side = false
  end
  def destroy
    uri = URI.parse('http://0.0.0.0:3000/api_session.json/1?auth_token=' + session[:api_token])
    puts 'before'
    http = Net::HTTP.new(uri.host, uri.port)
    puts 'after'
    request = Net::HTTP::Delete.new(uri.path)
    response = http.request(request)
    session[:api_token] = nil
    session[:user_login] = nil
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
end
