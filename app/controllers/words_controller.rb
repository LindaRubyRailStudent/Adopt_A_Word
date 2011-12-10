class WordsController < ApplicationController
  ## index action finds words by searching either the word, category or the type of word.
  ## using the paginate method only 15 words are displayed per page
   def index
  @words = Word.search(params[:search], params[:search2], params[:search3]).paginate(:per_page => 15,:page => params[:page])
  end

   ## show action will search for a word with a particular parameter
   ## if the current user is has a twitter authentication it will find tweets with that particular word
   ## if the current user has a facebook authentication it will find public facebook updates with that particular word
  def show
    @word = Word.find(params[:id])
    if current_user.authentications[2]=="twitter"
    @tweet_search =  current_user.twitter.search(@word.word)
    else
      @tweet_search
      end
  end

  ## method to adopt a word
  def adopt_word
    @word = Word.find(params[:id])
    @adoption = Adoption.new
    @adoption.adopt_a_word(word)
  end

   ## method to search word
   ## method is passed 3 parameters
  def search
    @search = Search.new(params[:search], params[:search2],params[:search3])

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end
end








