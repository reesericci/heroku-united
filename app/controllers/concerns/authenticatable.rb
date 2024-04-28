module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated
  end

  def ensure_authenticated
    if !request.env["warden"].authenticated?
      redirect_to login_path, flash: {error: (request.env["PATH_INFO"] == members_path) ? nil : "You need to sign in to access that page", redirect_back: request.env["PATH_INFO"]}
    end
  end
end
