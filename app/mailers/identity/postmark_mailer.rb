class Identity::PostmarkMailer < ApplicationMailer
  def new
    delivery_options = {
      user_name: Config.first.smtp[:username],
      password: Config.first.smtp[:password],
      address: Config.first.smtp[:server],
      port: Config.first.smtp[:port].to_i,
      domain: Config.first.smtp[:domain],
      authentication: :cram_md5,
      enable_starttls: true
    }

    @postmarkable = params[:postmarkable]

    @code = @postmarkable.imprint.code.create!.to_i

    mail(to: email_address_with_name(@postmarkable.email, @postmarkable.name),
      from: email_address_with_name("#{Config.first.smtp[:box]}@#{Config.first.smtp[:domain]}", Config.organization),
      subject: "Your #{Config.organization} login code is #{@code}",
      delivery_method_options: delivery_options)
  end
end
