class LoginsController < ApplicationController
  def new
    flash[:back] = flash[:redirect_back]
  end

  def create
    request.env['warden'].authenticate
    if !request.env['warden'].authenticated?
      flash[:error] = "Unable to log in, likely invalid email or password."
      redirect_back fallback_location: "/login"
      return
    end
    redirect_to (flash[:back] || root_path), flash: { error: nil }
  end

  def destroy
    request.env['warden'].logout
    redirect_to "/login"
  end
end
