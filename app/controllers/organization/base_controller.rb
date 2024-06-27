class Organization::BaseController < ApplicationController
  before_action :ensure_authenticated

  def ensure_authenticated
    if !request.env["warden"].authenticated?
      redirect_to new_organization_journey_path, flash: {error: (request.env["PATH_INFO"] == organization_members_path) ? nil : "You need to sign in to access that page", redirect_back: request.env["PATH_INFO"]}
    end
  end
end
