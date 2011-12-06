class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    ## first fetch the authentication find by provider
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    ## if authentication found sign the user in
    if authentication
      flash[:notice] = "Signed in Successfully"
      ## user the devise sign in method
      sign_in_and_redirect(:user, authentication.user)

      ## if no authentication found create the authentication
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication Successful"
      redirect_to authentications_url

      ## if a new user comes to the site and tries to sign in/up with twitter.
    else
      ## create a new user
      user = User.new
      ## add the authentication to that user
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice]= "Signed in successfully"
        sign_in_and_redirect(:user, user)
      else
        ## if validation fails - no email - then redirect the new user to a new user page
        ## store the omniauth info in a session  but it might be too big for storing in a cookie session so allow extra
        session[:omniauth]= omniauth
        redirect_to new_user_registration_path
      end
      #render :text => request.env["omniauth.auth"].to_yaml
    end
  end


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




