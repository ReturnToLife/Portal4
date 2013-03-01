require 'net/http'
require "uri"
class LoginController < ApplicationController
  def index
  end
def create
    uri = URI.parse('http://0.0.0.0:3000/api_session.json')

    @login = params[:log]
    @response = Net::HTTP.post_form(uri, {"login" => @login, "password" => params[:pass]})

  session[:api_token] = @response.body
   session[:user_login] = @login

end
end
