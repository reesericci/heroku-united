module Identity::Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated
  end

  def ensure_authenticated
    if !request.env["warden"].authenticated?(:identity)
      redirect_to login_path, flash: {redirect_back: request.env["PATH_INFO"]}
    end
  end
end
