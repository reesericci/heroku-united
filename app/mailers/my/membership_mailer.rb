class My::MembershipMailer < ApplicationMailer
  def created
    @member = params[:member]

    mail(to: email_address_with_name(@member.email, @member.name),
      subject: "Welcome to #{Config.organization}!")
  end

  def rejected
    @member = params[:member]

    mail(to: email_address_with_name(@member.email, @member.name),
      subject: "Your request to join #{Config.organization} was denied")
  end

  def petitioned
    @member = params[:member]

    mail(to: email_address_with_name(@member.email, @member.name),
      subject: "You've requested to join #{Config.organization}!")
  end
end
