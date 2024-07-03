class Passkey < ApplicationRecord
  belongs_to :keyring
  self.primary_key = "id"
end
