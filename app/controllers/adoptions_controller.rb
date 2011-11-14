class AdoptionsController < ApplicationController
#before_filter :login_required, :except => [:index, :show]

    def new
      @adoption = Adoption.new
    end
  def create
    if current_user.nil?
      redirect_to root_path
    else
      debugger
      @word = params[:id]
      @adoption = Adoption.new(:word_id => @word,:user_id => current_user.id)
      #provider = current_user.authentications.find_by_provider('twitter')
     #@twitter_user = Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret) rescue nil
     # @twitter_user.update('first tweet')
     # @twitter_status = current_user.twitter
     # @twitter_status.update('first tweet')
      current_user.twitter.update("I've just adopted a word from AdoptaWord")
     # @last_tweet = current_user.twitter.home_timeline.first
      #params[:word_id] = @adoption.word_id
      #@user = current_user
      #@word = Word.find(params[:id])
      #@adoption = @user.adoptions.build(:word_id => params[:word_id])
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


