class My::Payment::IntentsController < ActionController::API
  def create
    # standard:disable Rails/SaveBang
    @intent = Stripe::PaymentIntent.create({
      amount: Config.dues.fractional,
      currency: Config.dues.currency.iso_code.downcase,
      automatic_payment_methods: {enabled: true, allow_redirects: "never"},
      confirm: true,
      confirmation_token: params[:stripe_confirmation_token]
    })
    # standard:enable Rails/SaveBang

    render json: {
      client_secret: @intent.client_secret,
      id: @intent.id,
      status: @intent.status
    }
  end
end
