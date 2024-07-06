class Organization::BaseController < ApplicationController
  before_action :ensure_authenticated
  add_breadcrumb "Organization", :organization_members_path

  def ensure_authenticated
    if !request.env["warden"].authenticated?
      redirect_to new_organization_journey_path, flash: {error: (request.env["PATH_INFO"] == organization_members_path) ? nil : "You need to sign in to access that page", redirect_back: request.env["PATH_INFO"]}
    end
  end

  private

  # For demo mode
  def current_user
    request.env["warden"].user
  end

  def sign_out
    request.env["warden"].logout
  end

  def sign_in(config)
    request.env["warden"].set_user(config)
  end
end
