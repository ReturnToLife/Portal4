require 'net/http'
require "uri"
class LoginController < ApplicationController
  def index
    if params[:errorlogin] == "true"
      @errorlogin = true
    else
      @errorlogin = false
    end
    if params[:logout] == "true"
      @logout = true
    else
      @logout = false
    end
  end
  def create
    uri = URI.parse('http://0.0.0.0:3000/api_session.json')
    
    @login = params[:login]
    array = []
    array[0] = @login
    array[1] = params[:pass]
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
  end
  def view
    render :layout => 'login'
  end
  def signout
    uri = URI.parse('http://0.0.0.0:3000/api_session/1.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    
    session[:api_token] = nil
    session[:user_login] = nil
    redirect_to :action => "index", :logout => true
  end
end
