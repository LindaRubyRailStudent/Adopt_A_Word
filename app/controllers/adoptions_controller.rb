class AdoptionsController < ApplicationController
#before_filter :login_required, :except => [:index, :show]

    def new
      @adoption = Adoption.new
    end
  def create
    if current_user.nil?
      redirect_to root_path
      else
    @word = params[:id]
   @adoption = Adoption.new(:word_id => @word,:user_id => current_user.id)
    #params[:word_id] = @adoption.word_id
   #@user = current_user
   #@word = Word.find(params[:id])
  # @adoption = @user.adoptions.build(:word_id => params[:word_id])
    if @adoption.save
      flash[:notice]= "Word Adopted"
      redirect_to current_user
  else
    flash[:error]= " Error adopting this word"
    redirect_to root_url
  end
  end
  end
  end


