class UsersController < ApplicationController

  caches_page :show

  def index
    @user = User.all
  end

  def show
    if(params[:id] != nil)
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    #@user = params[:id].nil? ? User.find(params[:id]) : current_user
   #@user = current_user
    screenname = @user.authentications
    screenname.each do |n|
      if n.provider == "twitter"
    @another_tweet = @user.twitter.user_timeline(n.screenname)
      else
        @adoptions = @user.adoptions
        @adoptions.each do |w|
         @word =  Word.find_by_id(w[:word_id]).word
        end
        @facebook_post = @user.facebook.fetch.home(:q => 'Bajulate')
        @facebook_post.collection.each do |m|
          @message = m[:message]
          @message2 = m[:comments][:data]
        end
      end
    end
    end

  def find_user_words
    @adopted_word = Word.find_by_id(current_user.adoptions[:word_id])
    @word_test = Word.find_by_id(8122).word
  end

end
