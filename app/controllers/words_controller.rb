class WordsController < ApplicationController
  #def index
   # @words = Word.order('word').page(params[:page]).per_page(10)
   # @words = Word.search(params[:search]).order('word').paginate(:per_page => 10, :page => params[:page])
    #@words = Word.title_like_all(params[:search].to_s.split).order('word').paginate(:per_page => 10, :page =>params[:page])
  #end

 def index
  @words = Word.search(params[:search], params[:search2], params[:search3]).paginate(:per_page => 15,:page => params[:page])
   # @search = Word.search(params[:search])
   # @words = @search.paginate(:page => params[:page])
  end

  def show
    @word = Word.find(params[:id])
    if current_user.authentications[2]=="twitter"
    @tweet_search =  current_user.twitter.search(@word.word)
    else
      @tweet_search
      end
  end

  def adopt_word
    @word = Word.find(params[:id])
    @adoption = Adoption.new
    @adoption.adopt_a_word(word)
  end

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








