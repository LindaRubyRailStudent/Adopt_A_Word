class UsersController < ApplicationController
  ## show all Users
  def index
    @user = User.all
  end
  ## Display the Users Profile
  #
  # =================================
  #
  #
  def show
    if(params[:id] != nil)
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    ## @user = params[:id].nil? ? User.find(params[:id]) : current_user
    ## @user = current_user
    ## find the users authentications
    ## if the users authentication provider is twitter then search their twitter status timeline
    ## else find the users facebook timeline with words containing the users adopted words.
    @user.find_tweets(current_user)
   screenname = @user.authentications
   screenname.each do |n|
     if n.provider == "twitter"
    @another_tweet = @user.twitter.user_timeline(n.screenname).paginate(:per_page => 5, :page => params[:another_tweet])
      else
        @adoptions = @user.adoptions
        @adoptions.each do |w|
        @word =  Word.find_by_id(w[:word_id]).word
        end
        @facebook_post = @user.facebook.fetch.home(:q => 'alabandical')
        @facebook_post.collection.each do |m|
          @message = m[:message]
          @message2 = m[:comments][:data]
        end
      end
    end
  end
  end
