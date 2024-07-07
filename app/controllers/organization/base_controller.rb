class Organization::BaseController < ApplicationController
  before_action :ensure_authenticated
  add_breadcrumb "Organization", :organization_members_path

  def ensure_authenticated
    if !request.env["warden"].authenticated?
      Journey.basecamp = request.env["PATH_INFO"]
      redirect_to new_organization_journey_path
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
