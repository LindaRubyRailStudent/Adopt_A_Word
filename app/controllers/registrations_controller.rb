 ## inherit from Devise Registration Controller so we can override some of the functionality
class RegistrationsController < Devise::RegistrationsController

  ## method to clear out the session only if the session is not from a new user
  def create
  super
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  ## build a user model in new and create actions of this controller
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
