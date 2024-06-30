module Payable
  extend ActiveSupport::Concern

  included do
    has_many :payments, as: :payee, dependent: nil, autosave: true if Config.payable
  end

  def payment_processing?
    payments&.order(:created_at)&.last&.processing?.present?
  end
end
