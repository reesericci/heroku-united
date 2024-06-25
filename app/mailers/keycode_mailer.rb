class KeycodeMailer < ApplicationMailer
  def new
    @imprintor = params[:imprintor]

    @code = @imprintor.keycode_imprint.code.rotate!.to_i

    mail(to: email_address_with_name(@imprintor.email, @imprintor.name),
      subject: "Your #{Config.organization} login code is #{@code}")
  end
end
