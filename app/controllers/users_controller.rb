class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
#    if(params[:id] != nil)
#      @user = User.find(params[:id])
#    else
      @user = current_user
#    end
    #@user = params[:id].nil? ? User.find(params[:id]) : current_user
   #@user = current_user
    screenname = @user.authentications
    screenname.each do |n|
    @another_tweet = @user.twitter.user_timeline(n.screenname)
    end
    @another_tweet
  end

  def find_user_words
    @adopted_word = Word.find_by_id(current_user.adoptions[:word_id])
    @word_test = Word.find_by_id(8122).word
  end

end
