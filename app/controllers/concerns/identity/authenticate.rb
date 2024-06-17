module Identity::Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated
  end

  def ensure_authenticated
    if !request.env["warden"].authenticated?(:identity)
      session[:redirect] = request.env["PATH_INFO"]
      redirect_to new_identity_keycode_path
    end
  end
end
