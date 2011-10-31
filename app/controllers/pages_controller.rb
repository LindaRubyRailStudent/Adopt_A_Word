class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
    @about = "About"
  end

end
