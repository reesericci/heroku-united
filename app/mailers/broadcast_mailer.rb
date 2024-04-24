class BroadcastMailer < ApplicationMailer
  def broadcast_email
    delivery_options = {
      user_name: Config.first.smtp[:username],
      password: Config.first.smtp[:password],
      address: Config.first.smtp[:server],
      port: Config.first.smtp[:port].to_i,
      domain: Config.first.smtp[:domain],
      authentication: :cram_md5,
      enable_starttls: true
    }

    @member = params[:member]
    @broadcast = params[:broadcast]

    mail(to: email_address_with_name(@member.email, @member.name), 
        from: email_address_with_name("#{Config.first.smtp[:box]}@#{Config.first.smtp[:domain]}", Config.organization), 
        subject: @broadcast.subject,
        delivery_method_options: delivery_options
    )
  end
end
