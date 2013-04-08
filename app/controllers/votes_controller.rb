class VotesController < ApplicationController

  def voteForArticle
    uri = URI.parse('http://0.0.0.0:3000/score/voteArticle.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idArticle" => params[:idArticle]})
    redirect_to :controller => "articles", :action => 'show', :id => params[:idArticle]
    
  end
  def unvoteForArticle
    uri = URI.parse('http://0.0.0.0:3000/score/unvoteArticle.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idArticle" => params[:idArticle]})
    redirect_to :controller => "articles", :action => 'show', :id => params[:idArticle]
    
  end

  def voteForAcomment
    uri = URI.parse('http://0.0.0.0:3000/score/voteAcomment.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idAcomment" => params[:idAcomment]})
    redirect_to :controller => "articles", :action => 'show', :id => params[:idArticle]
    
  end
  def unvoteForAcomment
    uri = URI.parse('http://0.0.0.0:3000/score/unvoteAcomment.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idAcomment" => params[:idAcomment]})
    redirect_to :controller => "articles", :action => 'show', :id => params[:idArticle]
    
  end

  def voteForGcomment
    uri = URI.parse('http://0.0.0.0:3000/score/voteGcomment.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idGcomment" => params[:idGcomment]})
    redirect_to :controller => "gossips", :action => 'show', :id => params[:idGossip]
    
  end
  def unvoteForGcomment
    uri = URI.parse('http://0.0.0.0:3000/score/unvoteGcomment.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idGcomment" => params[:idGcomment]})
    redirect_to :controller => "gossips", :action => 'show', :id => params[:idGossip]
    
  end

  def voteForGossip
    uri = URI.parse('http://0.0.0.0:3000/score/voteGossip.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idGossip" => params[:idGossip]})
    redirect_to :controller => "articles", :action => 'index'
  end
  
  def voteAgainstGossip
    uri = URI.parse('http://0.0.0.0:3000/score/voteAgainstGossip.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idGossip" => params[:idGossip]})
    redirect_to :controller => "articles", :action => 'index'  
  end

  def unvoteForGossip
    uri = URI.parse('http://0.0.0.0:3000/score/unvoteGossip.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "idGossip" => params[:idGossip]})
    redirect_to :controller => "gossips", :action => 'show', :id => params[:idGossip]
    
  end
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(params[:vote])

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
end
