class Organization::PasskeysController < Organization::BaseController
  def index
  end

  def new
    if !Config.keyring
      Config.create_keyring
    end

    @options = Config.keyring.relying_party.options_for_registration(
      user: {id: Config.keyring.id, name: Config.email, display_name: Config.email},
      exclude: Config.keyring.passkeys.map { |p| p.id },
      authenticator_selection: {
        residentKey: "required",
        requireResidentKey: true,
        userVerification: "preferred"
      }
    )

    Passkey::Ceremony.reset
    Passkey::Ceremony.challenge = @options.challenge
  end

  def create
    webauthn_credential = Config.keyring.relying_party.verify_registration(
      JSON.parse(passkey_params[:credential]),
      Passkey::Ceremony.challenge
    )

    Config.keyring.passkeys.create!(
      id: webauthn_credential.id,
      name: passkey_params[:name],
      public_key: webauthn_credential.public_key,
      sign_count: webauthn_credential.sign_count
    )

    redirect_to organization_passkeys_path, status: :see_other
  end

  def destroy
    Config.keyring.passkeys.find(params[:id]).destroy!
    redirect_to organization_passkeys_path, status: :see_other
  end

  private

  def passkey_params
    params.require(:passkey).permit(:challenge, :credential, :name, :id)
  end
end
