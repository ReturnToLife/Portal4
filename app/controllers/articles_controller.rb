require 'json'
class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @show_header = true
    @show_right_side = false
    @show_left_side = false
    
    uri = URI.parse('http://0.0.0.0:3000/articles.json')
    
    @response = Net::HTTP.get(uri)
    
    @tab = JSON.parse(@response)
    
        
    @articles = Array.new
    @tab.each do |a|
      @articles.push(Article.new(a))
    end
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    uri = URI.parse('http://0.0.0.0:3000/articles/1.json')

    @response = Net::HTTP.get(uri)
  
    @article = Article.new.from_json(@response)


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
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
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    uri = URI.parse('http://0.0.0.0:3000/articles.json')

    @article = Article.new(params[:article])

    @response = Net::HTTP.post_form(uri, {"article" => render(:json => @article)})

  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
