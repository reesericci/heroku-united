class Payment < ApplicationRecord
  belongs_to :payee, polymorphic: true, autosave: true
  enum :state, {succeeded: "succeeded", processing: "processing", failed: "failed"}, default: :processing

  def to_stripe
    Stripe::PaymentIntent.retrieve(stripe_id)
  rescue Stripe::InvalidRequestError
    nil
  end
end
