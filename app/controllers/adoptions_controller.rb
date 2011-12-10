# The Adoptions Class links the Words to the Users
#
# === Adoptions
#
#  # there are 3 actions within the adoptions controller index, show, and new
class AdoptionsController < ApplicationController
#before_filter :login_required

# creates a new adoption
  def new
    @adoption = Adoption.new
  end

# shows adoptions through the fin method using an id parameter
  def show
    @adoption = Adoption.find_by_id(params[:id])
  end

# index action shows all the adoptions
  def index
    @adoptions = Adoption.all
  end

# creates a new adoption
#
# === Variables
#
# * +current_user+ is the logged in user
# * +@word+ is the id that is being passed in
# * +@tweet+ is the Word object with the matching id
# * +@adoption+ is a new Adoption object with the id of @word and the user_id of the current user
# * +@provider+ is an Authentication object that matches the current users id.
#
#
# ==== Examples
#
#  # If there is no logged in user redirect to the signin path
#  # If there is a logged in user create a new Adoption with the @word param and the current_user id
#  # Check if the current users provider is twitter or facebook
#  # If the current users Authentication provider attribute is twitter
#  # use the twitter method to update the current_users twitter status and pass the adopted word to it.
#  # If the current users Authentication provider is facebook
#  # then use the facebook method to access the current users feed and pass the adopted word to the update facebook wall post.
#  # If the adoption saves then redirect to the users profile page
# # If there is a problem then show a flash message saying there is a problem with the adoption
# # and redirect to the home page.

  def create
    if current_user.nil?
      redirect_to root_path
    else
      @word = params[:id]
      @tweet = Word.find_by_id(@word)
      @adoption = Adoption.new(:word_id => @word, :user_id => current_user.id)
      @provider = Authentication.find_by_user_id(current_user.id)

#
      if @provider[:provider] == "twitter"
        current_user.twitter.update("I've just adopted " + @tweet[:word] + " from Adopt_A_Word")
      else
        current_user.facebook.feed!(:message => 'I just adopted ' + @tweet[:word] + " from Adopt_A_Word")
      end
      if @adoption.save
        flash[:notice]= "Word Adopted"
        redirect_to usershow_path
      else
        flash[:error]= " Error adopting this word"
        redirect_to root_url
      end
    end
  end
end


#  def new
#      @adoption = Adoption.new
#  end
#
#  def create
#    if current_user.nil?
#      redirect_to root_path
#    else
#      @word = params[:id]
#      @word_tweet =  Word.find_by_id(params[:id]).word.capitalize
#      @adoption = Adoption.new(:word_id => @word,:user_id => current_user.id)
#      provider = current_user.authentications.find_by_provider('twitter')
#     #@twitter_user = Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret) rescue nil
#     # @twitter_user.update('first tweet')
#     # @twitter_status = current_user.twitter
#     # @twitter_status.update('first tweet')
#      current_user.twitter.update( 'I just adopted ' + @word_tweet + ' from AdoptAWord')
##      current_user.adoptions.words do |w|
##        @search = current_user.twitter_search.containing(w[:word]).result_type("recent").each do |t|
##          @p = t[:text]
##        end
##      end
#
##      @wordadoptions.each do |w|
##         @search = current_user.twitter_search.containing(Word.find_by_id(w.word_id)[:word]).result_type("recent").each do |t|
##           @p = t[:text]
##          end
##      end
#end
#     # @last_tweet = current_user.twitter.home_timeline.first
#      params[:word_id] = @adoption.word_id
#      @user = current_user
#      @word = Word.find(params[:id])
#      @adoption = @user.adoptions.build(:word_id => params[:word_id])
#    if @adoption.save
#      flash[:notice]= "Word Adopted"
#      redirect_to usershow_path
#    else
#    flash[:error]= " Error adopting this word"
#    redirect_to root_url
#  end
#  end
#  end


