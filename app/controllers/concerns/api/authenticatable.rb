module Api::Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated
  end

  def ensure_authenticated
    if !authenticate_with_http_basic { |i, k| Api::Key.find_by(id: i)&.authenticate(k) }
      render plain: "Unable to authenticate. Likely invalid ID or key", status: 400
    end
  end
end
