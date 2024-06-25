module Secrecy
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated
  end

  def ensure_authenticated
    if !request.env["warden"].authenticated?
      redirect_to "/secret/rendezvous/new", flash: {error: (request.env["PATH_INFO"] == "/secret/members") ? nil : "You need to sign in to access that page", redirect_back: request.env["PATH_INFO"]}
    end
  end
end
