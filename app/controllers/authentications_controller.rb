class AuthenticationsController < ApplicationController
# # === Authentications Controller has  4 actions
#
#
# # index finds the @authentication of the current user if the user is logged in and current
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    # # omniauth is the hash that is delivered by the omniauth gem
    omniauth = request.env["omniauth.auth"]
    # # first fetch the authentication find by provider
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    # # if authentication found sign the user in
    if authentication
      flash[:notice] = "Signed in Successfully"
      # # use the devise sign in method
      sign_in_and_redirect(:user, authentication.user)
      # # if no authentication found create the authentication
    elsif current_user
      # # creates an authentication for the current user with the attributes provider and uid obtained from the omniauth hash
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      # # let the user know with the flash message that the authentication has been successful
      flash[:notice] = "Authentication Successful"
      # # redirect to the index action of the authentications controller
      redirect_to authentications_url
      # # if a new user comes to the site and tries to sign in/up with twitter.
    else
      # # create a new user
      user = User.new
      # # add the authentication to that user from the omniauth hash
      user.apply_omniauth(omniauth)
      # # create the user and redirect to the user profile
      if user.save
        flash[:notice]= "Signed in successfully"
        sign_in_and_redirect(:user, user)
      else
        # # if validation fails - no email - then redirect the new user to a new user page
        # # store the omniauth info in a session  but it might be too big for storing in a cookie session so allow extra
        session[:omniauth]= omniauth.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end

  # # destroy method finds the current users authentications with a particular id
  # # once the authentication has been found the authentication is destroyed
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication"
    redirect_to authentications_url
  end

  protected

  def handle_unverified_request
    true
  end
end




