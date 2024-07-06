class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: {chrome: 105, firefox: 110, safari: 12}

  before_action :ensure_configured

  private

  def ensure_configured
    unless Config.first
      redirect_to new_organization_config_path
    end
  end
end
