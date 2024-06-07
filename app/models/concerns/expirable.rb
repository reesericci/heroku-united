module Expirable
  extend ActiveSupport::Concern

  included do
    scope :expired, -> { where "expires_at < NOW()" }
  end

  def expired?
    expires_at&.< DateTime.now
  end
end