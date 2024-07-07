class Organization::Keyring < Keyring
  self.relying_party = WebAuthn::RelyingParty.new(
    origin: Config.external_url,
    name: "#{Config.organization} Administration"
  )
  attribute :type, :string, default: -> { "Organization::Keyring" }
end
