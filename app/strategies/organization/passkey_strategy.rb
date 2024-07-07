class Organization::PasskeyStrategy < Warden::Strategies::Base
  def valid?
    journey_params.permitted?
  end

  def authenticate!
    credential, passkey = Journey.explorer.keyring.relying_party.verify_authentication(
      JSON.parse(journey_params[:credential]),
      Passkey::Ceremony.challenge
    ) do |credential|
      Journey.explorer.keyring.passkeys.find(credential.id)
    end

    passkey.update!(sign_count: credential.sign_count)

    raise "not a Config!" unless Journey.explorer.is_a? Config

    success!(passkey.keyring.keyable)
  rescue
    fail!("Could not log in")
  end

  private

  def journey_params
    ActionController::Parameters.new(params).require(:journey).permit(:username, :credential)
  end
end