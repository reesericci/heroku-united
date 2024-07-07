class ClearanceMailer < ApplicationMailer
  def administrator_alert
    @petitioner = params[:petitioner]
    mail(to: email_address_with_name(Config.email, "#{Config.organization} Administrator"),
      from: email_address_with_name("#{Config.smtp[:box]}@#{Config.smtp[:domain]}", Config.organization),
      subject: "#{@petitioner.name} has requested to become a member of #{Config.organization}")
  end
end
