require 'net/http'
require "uri"
class HomeController < ApplicationController
  def index

uri = URI.parse('http://0.0.0.0:3000/api_session.json')

@response = Net::HTTP.post_form(uri, {"login" => "bideau_s", "password" => "12345678"})

#require 'net/http'
#uri = URI.parse('http://0.0.0.0:3000')
# Full
#http = Net::HTTP.new(uri.host, uri.port)
#response = http.request(Net::HTTP::Get.new(uri.request_uri))
 end

def login

uri = URI.parse('http://0.0.0.0:3000/users/login')

@response = Net::HTTP.post_form(uri, {"login" => "munoz_v", "mdp" => "toto42"})


#
#uri = URI.parse('http://0.0.0.0:3000/login')

#http = Net::HTTP.new(uri.host, uri.port)

#request = Net::HTTP::Get.new(uri.request_uri)

#request.basic_auth("username", "password")

#response = http.request(request)
end 
end

