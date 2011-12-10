class PostsController < ApplicationController
  # = Posts
  #
  # creates a new post
  # can respond to either html or json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # creates a new post from the params being passed by the form
  # flashes a notice to thank the yser for making the post
  # the action can render to html, javascript or json
  def create
    @post = Post.create!(params[:post])
    flash[:notice] = "Thankyou for making this comment"
    respond_to do |format|
      format.html { redirect_to usershow_path }
      format.js
      format.json { render :json => @post,
                           :status => :created, :location => @post }
    end
  end

  # the index action finds all the posts using the .all method
  def index
    @posts = Post.all
  end

  # the show action finds all the posts matching the id params
  # the show action can render html and json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # the edit action allows users to edit a post and searches for a post based on id
  def edit
    @post = Post.find(params[:id])
  end

  # the update method allows users to update a post
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post,
                                  :notice => 'Post was successfully updated.') }
        format.json { render :json => {}, :status => :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # the destroy action allows the
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

end


