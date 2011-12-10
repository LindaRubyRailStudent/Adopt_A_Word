class PagesController < ApplicationController
# # creates a home action for the Pages controller
  def home
    @title = "Home"
  end
# # creates an about action for the Pages controller
  def about
    @about = "About"
  end
end
