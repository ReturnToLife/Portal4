require 'json'
require 'net/http'
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    uri = URI.parse('http://0.0.0.0:3000/users/' + params[:id] + '.json?auth_token=' + session[:api_token])
#    @user = User.find(params[:id])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @user = User.new(hash["user"])
    @arrayArticles = []
    @arrayAcomments = []
    hash["articles"].each {|article| @arrayArticles.append(Article.new(article))}
    hash["acomments"].each {|comment| @arrayAcomments.append(Acomment.new(comment))}
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update

    uri = URI.parse('http://0.0.0.0:3000/users/' + params[:id] + '/update.json' )
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], :file => params[:user][:photo].tempfile.read, :filename => params[:user][:photo].original_filename, :content_type => params[:user][:photo].content_type})
    redirect_to("/users/" + params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
