require 'json'
require 'net/http'
class AcommentsController < ApplicationController
  def create
    @carbon = true
    uri = URI.parse('http://0.0.0.0:3000/articles/' + params[:article_id] + '/acomments.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "acomment" => render(:json => {:user => session[:user_login],:body => params[:acomment][:body]})})
   end
  def   destroy
# /articles/:article_id/acomments/:id(.:format)
   uri = URI.parse('http://0.0.0.0:3000/articles/' + params[:article_id] + '/acomments/' + params[:id] + '.json?auth_token=' + session[:api_token])
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Delete.new(uri.path)
    response = http.request(request)
    puts "##################################################"
    puts response.code
    puts response.body
    respond_to do |format|
      format.html { redirect_to "/articles/" + params[:article_id] }
      format.json { head :no_content }
    end
  end
end
