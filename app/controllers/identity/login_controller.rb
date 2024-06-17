class Identity::LoginController < ApplicationController
  def new
    if flash[:member_username].blank?
      redirect_to new_identity_keycode_path and return
    end
    @username = flash[:member_username]
  end

  def create
    request.env["warden"].authenticate(:keycode, scope: :identity)
    if !request.env["warden"].authenticated?(:identity)
      flash[:error] = "Unable to log in"
      flash[:member_username] = params[:login][:username]
      redirect_back fallback_location: new_identity_login_path
      return
    end
    if session[:redirect].blank?
      flash[:member_username] = params[:login][:username]
      flash[:error] = "No path to redirect to provided by application."
      redirect_back fallback_location: new_identity_login_path
      return
    end
    redirect_to session[:redirect], status: :see_other
  end

  def destroy
    request.env["warden"].logout(:identity)
    redirect_to new_identity_login_path
  end
end
