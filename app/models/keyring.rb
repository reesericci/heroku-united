class Keyring < ApplicationRecord
  has_many :passkeys, dependent: :destroy
  belongs_to :keyable, polymorphic: true
  attribute :id, :text, default: -> { WebAuthn.generate_user_id }

  self.table_name = "keyrings"
  self.primary_key = "id"

  cattr_accessor :relying_party

  def authenticate!(key, challenge)
    credential, passkey = relying_party.verify_authentication(key, challenge) do |credential|
      passkeys.find(credential.id)
    end

    passkey.update!(sign_count: credential.sign_count)

    self
  end
end
