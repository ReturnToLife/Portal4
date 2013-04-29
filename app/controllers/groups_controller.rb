class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    uri = URI.parse('http://0.0.0.0:3000/groups.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @groups = []
    hash.each do |group|
      @groups.push(Group.new(group))
    end
    
  end

  
  # GET /groups/1
  # GET /groups/1.json
  def show


    uri = URI.parse('http://0.0.0.0:3000/groups/' + params[:id] + '.json?auth_token=' + session[:api_token])
  
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @group = Group.new(hash["group"])
    @members = hash["members"]
    @members_info = hash["members_info"]
    @is_admin = hash["is_admin"] 
    @is_member = hash["is_member"] 
    if (@is_member == "false")
      redirect_to :action => "fail", :id => params[:id], :name => @group.title
    else
      #call to article
      uri = URI.parse('http://0.0.0.0:3000/articles.json?group_id=' + params[:id]+ '&auth_token=' + session[:api_token])
      @response = Net::HTTP.get(uri)
      
      @articles = JSON.parse(@response)
      #end call to article
      
      # call to gossip
      uri = URI.parse('http://0.0.0.0:3000/gossips.json?group_id=' + params[:id]+ '&auth_token=' + session[:api_token])
      @response = Net::HTTP.get(uri)
      hash2 = ActiveSupport::JSON.decode(@response)
      i = 0
      hash2.each do |elem|
        if i == 0
          @gossips = elem['gossips']
          @scores = elem['scores']
          @votestab = elem['votes']
        end
        i = 1
      end
      
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @group }
      end
    end
  end

  def savemember
    uri = URI.parse('http://0.0.0.0:3000/groups/' + params[:id] + '/savemember.json')
    
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "login" => params[:login], "group_id" => params[:id],  "job" => params[:job]})

      redirect_to :action => "show", :id => params[:id]
  end

  def addmember
    @id = params[:id]
    respond_to do |format|
      format.html # addmember.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    uri = URI.parse('http://0.0.0.0:3000/groups.json')
    @group = Group.new(params[:group])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "group" => @group.to_json})

    @group = Group.new.from_json(@response.body)
    redirect_to :action => "show", :id => @group.id
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
  
  def fail
    @name = params[:name]

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
