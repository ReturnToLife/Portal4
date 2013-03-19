require 'json'
require 'net/http'
class AcommentsController < ApplicationController

  def create
    uri = URI.parse('http://0.0.0.0:3000/articles/' + params[:article_id] + '/acomments.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], :body => params[:acomment][:body]})
    redirect_to "/articles/" + params[:article_id]
   end

  def   destroy
    uri = URI.parse('http://0.0.0.0:3000/articles/' + params[:article_id] + '/acomments/delete/' + params[:id] + '.json')

    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], :article_id => params[:article_id]})
    if @response.code == "200"
      respond_to do |format|
        format.html { redirect_to @response.body }
        format.json { head :no_content }
      end
    end
  end
end
