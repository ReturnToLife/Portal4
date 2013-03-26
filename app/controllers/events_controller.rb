require 'json'
require 'net/http'
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    if (session[:api_token] == nil)
      respond_to do |format|
        format.html { redirect_to login_url, notice: 'You need to log in' }
      end
    end
    uri = URI.parse('http://0.0.0.0:3000/events.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    
    @events = JSON.parse(@response)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
        uri = URI.parse('http://0.0.0.0:3000/events/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @event = Event.new(hash["event"])
    @login = session[:user_login]
    @author_name = hash["login"]

    respond_to do |format|
      format.html # show.html.erb
      format.json {render json: {:event => @event, :login => @login, :author_name => @author_name }}
    end
  end
  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    uri = URI.parse('http://0.0.0.0:3000/events/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash =  ActiveSupport::JSON.decode(@response)
    @event = Event.new(hash["event"])
    @login = session[:user_login]
    @author_name = hash["login"]
  end

  # POST /events
  # POST /events.json
  def create
    uri = URI.parse('http://0.0.0.0:3000/events.json')
    @event = Event.new(params[:event])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "event" => @event.to_json})
    print  "#########################"
    print @response.body
    @event = Event.new.from_json(@response.body)
    redirect_to("/events")
#    redirect_to :action => "show", :id => @event.id
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
