class PostsController < ApplicationController
  def new
  @post = Post.new

  respond_to do |format|
    format.html  # new.html.erb
    format.json  { render :json => @post }
  end
  end

  def create
  @post = Post.create!(params[:post])
  flash[:notice] = "Thankyou for making this comment"
  respond_to do |format|
      format.html {redirect_to usershow_path}
      format.js
      format.json  { render :json => @post,
                    :status => :created, :location => @post }
  end
end

  def index
    @posts = Post.all
  end

  def show
  @post = Post.find(params[:id])

  respond_to do |format|
    format.html  # show.html.erb
    format.json  { render :json => @post }
  end
end

def edit
  @post = Post.find(params[:id])
end

  def update
  @post = Post.find(params[:id])

  respond_to do |format|
    if @post.update_attributes(params[:post])
      format.html  { redirect_to(@post,
                    :notice => 'Post was successfully updated.') }
      format.json  { render :json => {}, :status => :ok }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @post.errors,
                    :status => :unprocessable_entity }
    end
  end
end
  def destroy
  @post = Post.find(params[:id])
  @post.destroy

  respond_to do |format|
    format.html { redirect_to posts_url }
    format.json { head :ok }
  end
end

  end


