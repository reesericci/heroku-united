class My::Keyring < Keyring
  self.relying_party = WebAuthn::RelyingParty.new(
    origin: Config.external_url,
    name: "My #{Config.organization} Membership"
  )
  attribute :type, :string, default: -> { "My::Keyring" }
end
