class UsersController < ApplicationController
  def index
    @user = User.all
  end
  def show
    debugger
    @user = current_user
    @last_tweet = current_user.twitter.user_timeline('LindaKeating2').first.text
    @last_tweet

    @another_tweet = current_user.twitter.home_timeline
    @another_tweet
  end

  def find_user_words
    @adopted_word = Word.find_by_id(current_user.adoptions[:word_id])
    @word_test = Word.find_by_id(8122).word
  end

end
