class My::Journey::Strategies::Passkey::AuthenticationsController < My::Journey::BaseController
  def new
    @options = Journey.explorer.keyring.relying_party.options_for_authentication

    Passkey::Ceremony.reset
    Passkey::Ceremony.challenge = @options.challenge
  end

  def create
    request.env["warden"].authenticate(:my_passkey, scope: :my)
    if !request.env["warden"].authenticated?(:my)
      flash[:error] = "Unable to log in"
      redirect_back fallback_location: new_my_passkey_authentication_path, status: :see_other
      return
    end
    if Journey.basecamp.blank?
      flash[:error] = "We don't know where you're visiting. Try restarting this flow again from the beginning."
      redirect_back fallback_location: new_my_passkey_authentication_path, status: :see_other
      return
    end
    redirect_to Journey.basecamp, status: :see_other
  end
end
