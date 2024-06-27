class My::JourneysController < ApplicationController
  def new
    if flash[:member_username].blank?
      redirect_to new_my_keycode_path and return
    end
    @username = flash[:member_username]
  end

  def create
    request.env["warden"].authenticate(:keycode, scope: :my)
    if !request.env["warden"].authenticated?(:my)
      flash[:error] = "Unable to log in"
      flash[:member_username] = params[:journey][:username]
      redirect_back fallback_location: new_my_journey_path
      return
    end
    if session[:redirect].blank?
      flash[:member_username] = params[:journey][:username]
      flash[:error] = "No path to redirect to provided by application."
      redirect_back fallback_location: new_my_journey_path
      return
    end
    redirect_to session[:redirect], status: :see_other
  end

  def delete
    request.env["warden"].logout(:my)
    redirect_to new_my_journey_path
  end
end
