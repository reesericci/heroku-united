class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("#{Config.smtp&.dig(:box)}@#{Config.smtp&.dig(:domain)}", Config.organization),
    user_name: Config.smtp[:username],
    password: Config.smtp[:password],
    address: Config.smtp[:server],
    port: Config.smtp[:port].to_i,
    domain: Config.smtp[:domain],
    authentication: :cram_md5,
    enable_starttls: true,
    reply_to: Config.email
  layout "mailer"
end
