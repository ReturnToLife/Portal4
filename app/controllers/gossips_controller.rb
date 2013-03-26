require 'json'
require 'net/http'

class GossipsController < ApplicationController
  # GET /gossips
  # GET /gossips.json
  def index
    uri = URI.parse('http://0.0.0.0:3000/gossips.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)

    @gossips = JSON.parse(@response)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gossips }
    end
  end

  # GET /gossips/1
  # GET /gossips/1.json
  def show
    uri = URI.parse('http://0.0.0.0:3000/gossips/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @comments = hash["comments"]
    @login = session[:user_login]
    @author_name = hash["login"]
    @gossip = Gossip.new(hash["gossip"])
    @votes = hash['votes']
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gossip }
    end
  end

  # GET /gossips/new
  # GET /gossips/new.json
  def new
    @gossip = Gossip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gossip }
    end
  end

  # GET /gossips/1/edit
  def edit
    @gossip = Gossip.find(params[:id])
  end

  # POST /gossips
  # POST /gossips.json
  def create
    uri = URI.parse('http://0.0.0.0:3000/gossips.json')
    @gossip = Gossip.new(params[:gossip])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "gossip" => @gossip.to_json})

    @gossip = Gossip.new.from_json(@response.body)
    redirect_to :action => "show", :id => @gossip.id
  end

  # PUT /gossips/1
  # PUT /gossips/1.json
  def update
    @gossip = Gossip.find(params[:id])

    respond_to do |format|
      if @gossip.update_attributes(params[:gossip])
        format.html { redirect_to @gossip, notice: 'Gossip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gossips/1
  # DELETE /gossips/1.json
  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy

    respond_to do |format|
      format.html { redirect_to gossips_url }
      format.json { head :no_content }
    end
  end
end
