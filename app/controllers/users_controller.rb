class UsersController < ApplicationController
  def index
    @user = User.all
  end
  def show
    @user = current_user
  end

  def find_user_words
    @adopted_word = Word.find_by_id(current_user.adoptions[:word_id])
    @word_test = Word.find_by_id(8122).word
  end

end
