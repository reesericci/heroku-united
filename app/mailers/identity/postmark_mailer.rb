class Identity::PostmarkMailer < ApplicationMailer
  def new
    @postmarkable = params[:postmarkable]

    @code = @postmarkable.imprint.code.create!.to_i

    mail(to: email_address_with_name(@postmarkable.email, @postmarkable.name),
      subject: "Your #{Config.organization} login code is #{@code}")
  end
end
