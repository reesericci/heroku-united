class My::MembershipMailer < ApplicationMailer
  def created
    @member = params[:member]

    mail(to: email_address_with_name(@member.email, @member.name),
      subject: "Welcome to #{Config.organization}!")
  end
end
