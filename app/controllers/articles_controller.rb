require 'json'
require 'net/http'
class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    if (session[:api_token] == nil)
      respond_to do |format|
        format.html { redirect_to login_url, notice: 'You need to log in' }
      end
    end
    uri = URI.parse('http://0.0.0.0:3000/articles.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    
    @articles = JSON.parse(@response)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/list
  # GET /articles/list.json
  def list
    uri = URI.parse('http://0.0.0.0:3000/articles.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    @tab = JSON.parse(@response)
    @articles = Array.new
    @tab.each do |a|
      @articles.push(Article.new(a))
    end
   
    respond_to do |format|
      format.html # list.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    uri = URI.parse('http://0.0.0.0:3000/articles/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash = ActiveSupport::JSON.decode(@response)
    @comments = hash["comments"]
    @article = Article.new(hash["article"])
    @login = session[:user_login]
    @author_name = hash["login"]
    @votes = hash["votes"]
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {:article => @article, :comments => @comments, :login => @login, :author_name => @author_name }}
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    uri = URI.parse('http://0.0.0.0:3000/articles/' + params[:id] + '.json?auth_token=' + session[:api_token])
    @response = Net::HTTP.get(uri)
    hash =  ActiveSupport::JSON.decode(@response)
    @id = hash["article"]["id"]
  end

  # POST /articles
  # POST /articles.json
  def create
    uri = URI.parse('http://0.0.0.0:3000/articles.json')
    @article = Article.new(params[:article])
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "article" => @article.to_json})

    @article = Article.new.from_json(@response.body)
    redirect_to :action => "show", :id => @article.id
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.new(params[:article])
    uri = URI.parse('http://0.0.0.0:3000/articles/' + @article.id + '.json' )
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token], "article" => render(:json => @article)})
    redirect_to :action => "show", :id => @article.id
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    
    uri = URI.parse('http://0.0.0.0:3000/articles/delete/' + params[:id] + '.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token]})

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def filterbylogin
    if (session[:api_token] == nil)
      respond_to do |format|
        format.html { redirect_to login_url, notice: 'You need to log in' }
      end
    end
    uri = URI.parse('http://0.0.0.0:3000/articles/filterbylogin/' + params[:login] + '.json')
    @response = Net::HTTP.post_form(uri, {"auth_token" => session[:api_token]})
    @tab = JSON.parse(@response.body)
    @articles = Array.new
    @tab.each do |a|
      @articles.push(Article.new(a))
    end
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end
end
