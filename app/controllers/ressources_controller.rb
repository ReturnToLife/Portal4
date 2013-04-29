class RessourcesController < ApplicationController
  # GET /ressources
  # GET /ressources.json
  def index
    uri = URI.parse('http://0.0.0.0:3000/ressources.json?group_id=' + params[:group_id] + '&auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)


    uri = URI.parse('http://0.0.0.0:3000/groups/' + params[:group_id] + '.json?auth_token=' + session[:api_token])
  
    @response2 = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response2)
    @group = Group.new(hash["group"])
    @group_name = @group.title


    @ressources = JSON.parse(@response)
    @arr = []
    @ressources.each do |ressource|
      @arr.push(Ressource.new(ressource))
    end
    @ressources = @arr
    @group_id = params[:group_id]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ressources }
    end
  end

  # GET /ressources/1
  # GET /ressources/1.json
  def show
    @group_id = params[:group_id]
    uri = URI.parse('http://0.0.0.0:3000/ressources/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @ressource = Ressource.new(hash["ressource"])
    @login = hash["login"]

    uri = URI.parse('http://0.0.0.0:3000/groups/' + params[:group_id] + '.json?auth_token=' + session[:api_token])
  
    @response2 = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response2)
    @group = Group.new(hash["group"])
    @group_name = @group.title

  end

  # GET /ressources/new
  # GET /ressources/new.json
  def new
    @ressource = Ressource.new
    @group_id = params[:group_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ressource }
    end
  end

  # GET /ressources/1/edit
  def edit
    @group_id = params[:group_id]
    uri = URI.parse('http://0.0.0.0:3000/ressources/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @ressource = Ressource.new(hash["ressource"])
  end

  # POST /ressources
  # POST /ressources.json
  def create
    
    uri = URI.parse('http://0.0.0.0:3000/ressources.json')
    @ressource = Ressource.new(params[:ressource])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "ressource" => @ressource.to_json, "group_id" => params[:group_id]})

    @ressource = Ressource.new.from_json(@response.body)
    redirect_to :action => "show", :id => @ressource.id, :group_id => params[:group_id]
  end

  # PUT /ressources/1
  # PUT /ressources/1.json
  def update
    uri = URI.parse('http://0.0.0.0:3000/ressources/'+ params[:ressource][:id] + '.json')
    @ressource = Ressource.new(params[:ressource])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "ressource" => @ressource.to_json, "group_id" => params[:group_id]})

    redirect_to :action => "show", :id => @ressource.id, :group_id => params[:group_id]


  end

  # DELETE /ressources/1
  # DELETE /ressources/1.json
  def destroy
    uri = URI.parse('http://0.0.0.0:3000/ressources/delete/' + params[:id] + '.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token]})

    redirect_to :action => "index", :group_id => params[:group_id]
  end
end
