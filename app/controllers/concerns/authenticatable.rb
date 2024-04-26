module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated
  end

  def ensure_authenticated
    if !request.env['warden'].authenticated?
      redirect_to "/login", flash: { error: "You need to sign in to access that page", redirect_back: request.env['PATH_INFO'] }
    end
  end
end