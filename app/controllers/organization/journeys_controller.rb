class Organization::JourneysController < ApplicationController
  def new
    flash[:back] = flash[:redirect_back]
  end

  def create
    request.env["warden"].authenticate
    if !request.env["warden"].authenticated?
      flash[:error] = "Unable to log in, likely invalid email or password."
      redirect_back fallback_location: new_organization_journey_path
      return
    end
    redirect_to (flash[:back] || organization_members_path), flash: {error: nil}
  end

  def delete
    request.env["warden"].logout
    redirect_to new_organization_journey_path
  end
end
