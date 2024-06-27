module Verifiable
  extend ActiveSupport::Concern

  included do
    has_one :verification, dependent: :destroy, as: :verifiable

    delegate :verified_at, to: :verification, allow_nil: true
  end

  def verify
    create_verification!(verified: true, verified_at: DateTime.now) unless verified?
  end

  def verified?
    verification&.verified?.present?
  end
end
