class Organization::Journey::Strategies::Passkey::AuthenticationsController < Organization::Journey::Strategies::BaseController
  def new
    @options = Journey.explorer.keyring.relying_party.options_for_authentication

    Passkey::Ceremony.reset
    Passkey::Ceremony.challenge = @options.challenge

    add_breadcrumb "Passkey", :new_organization_passkey_authentication_path
  end

  def create
    request.env["warden"].authenticate(:organization_passkey)
    if !request.env["warden"].authenticated?
      flash[:error] = "Unable to log in"
      redirect_back fallback_location: new_organization_passkey_authentication_path, status: :see_other
      return
    end
    redirect_to (Journey.basecamp || organization_members_path), status: :see_other
  end
end