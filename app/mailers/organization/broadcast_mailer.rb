class Organization::BroadcastMailer < ApplicationMailer
  def new
    @member = params[:member]
    @broadcast = params[:broadcast]

    mail(to: email_address_with_name(@member.email, @member.name),
      from: email_address_with_name("#{Config.first.smtp[:box]}@#{Config.first.smtp[:domain]}", Config.organization),
      subject: @broadcast.subject)
  end
end
