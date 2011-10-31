class WordsController < ApplicationController
  #def index
    #@words = Word.order('word').page(params[:page]).per_page(10)
    #@words = Word.search(params[:search]).order('word').paginate(:per_page => 10, :page => params[:page])
    #@words = Word.title_like_all(params[:search].to_s.split).order('word').paginate(:per_page => 10, :page =>params[:page])
  #end

 def index
    @search = Word.search(params[:search])
    @words = @search.paginate(:page => params[:page])
  end

  def show
    @word = Word.find(params[:id])
  end

  def adopt_word
    @word = Word.find(params[:id])
    @adoption = Adoption.new
    @adoption.adopt_a_word(word)
  end
end





