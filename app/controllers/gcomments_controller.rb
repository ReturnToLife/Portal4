class GcommentsController < ApplicationController
  def create
    uri = URI.parse('http://0.0.0.0:3000/gossips/' + params[:gossip_id] + '/gcomments.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], :body => params[:gcomment][:body]})
    redirect_to "/gossips/" + params[:gossip_id]
   end

  def   destroy
    uri = URI.parse('http://0.0.0.0:3000/gossips/' + params[:gossip_id] + '/gcomments/delete/' + params[:id] + '.json')

    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], :gossip_id => params[:gossip_id]})
    if @response.code == "200"
      respond_to do |format|
        format.html { redirect_to @response.body }
        format.json { head :no_content }
      end
    end
  end

end
