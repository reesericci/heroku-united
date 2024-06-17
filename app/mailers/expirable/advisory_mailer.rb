class Expirable::AdvisoryMailer < ApplicationMailer
  # TODO: don't love the implicit dependency on email and name

  def expired
    @expirable = params[:expirable]

    @expirable.update!(expiry_advised: :expired)

    mail(to: email_address_with_name(@expirable.email, @expirable.name),
      subject: "Your #{Config.organization} #{@expirable.class.condition} has expired.")
  end

  def day
    advisory "tomorrow", :day
  end

  def week
    advisory "in a week", :week
  end

  def month
    advisory "in a month", :month
  end

  private

  def advisory(timeframe, expiry_advised)
    @expirable = params[:expirable]
    @timeframe = timeframe

    @expirable.update!(expiry_advised: expiry_advised)

    mail(to: email_address_with_name(@expirable.email, @expirable.name),
      subject: "Your #{Config.organization} #{@expirable.class.condition} will expire #{timeframe}",
      template_name: "advisory")
  end
end
