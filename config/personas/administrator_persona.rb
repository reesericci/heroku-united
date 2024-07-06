DemoMode.add_persona do
  features << "Full administrator access"

  callout true
  display_credentials true

  sign_in_as do
    Config.first.update!(password: DemoMode.current_password)
    Config.first
  end

  begin_demo do
    request.env["warden"].set_user(@session.signinable)
    redirect_to "/organization"
  end
end
