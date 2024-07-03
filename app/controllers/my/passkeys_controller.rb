class My::PasskeysController < My::BaseController
  def index
  end

  def new
    if !My.keyring
      My.create_keyring
    end

    @options = My.keyring.relying_party.options_for_registration(
      user: {id: My.keyring.id, name: My.username, display_name: My.name},
      exclude: My.keyring.passkeys.map { |p| p.id },
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
    webauthn_credential = My.keyring.relying_party.verify_registration(
      JSON.parse(passkey_params[:credential]),
      Passkey::Ceremony.challenge
    )

    My.keyring.passkeys.create!(
      id: webauthn_credential.id,
      name: passkey_params[:name],
      public_key: webauthn_credential.public_key,
      sign_count: webauthn_credential.sign_count
    )

    redirect_to my_passkeys_path, status: :see_other
  end

  def destroy
    My.keyring.passkeys.find(params[:id]).destroy!
    redirect_to my_passkeys_path, status: :see_other
  end

  private

  def passkey_params
    params.require(:passkey).permit(:challenge, :credential, :name, :id)
  end
end
