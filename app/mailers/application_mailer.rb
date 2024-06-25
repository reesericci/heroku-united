class ApplicationMailer < ActionMailer::Base
  after_action :set_delivery_options

  layout "mailer"

  default from: email_address_with_name("#{Config.smtp&.dig(:box) || "changeme"}@#{Config.smtp&.dig(:domain) || "example.com"}", Config.organization || "United"),
    user_name: Config.smtp&.dig(:username),
    password: Config.smtp&.dig(:password),
    address: Config.smtp&.dig(:server),
    port: Config.smtp&.dig(:port)&.to_i,
    domain: Config.smtp&.dig(:domain),
    authentication: :cram_md5,
    enable_starttls: true,
    reply_to: Config.email

  private

  def set_delivery_options
    mail.delivery_method.settings.merge!({
      from: email_address_with_name("#{Config.smtp&.dig(:box) || "changeme"}@#{Config.smtp&.dig(:domain) || "example.com"}", Config.organization || "United"),
      user_name: Config.smtp&.dig(:username),
      password: Config.smtp&.dig(:password),
      address: Config.smtp&.dig(:server),
      port: Config.smtp&.dig(:port)&.to_i,
      domain: Config.smtp&.dig(:domain),
      authentication: :cram_md5,
      enable_starttls: true,
      reply_to: Config.email
    })
  end
end
