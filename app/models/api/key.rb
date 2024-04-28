class Api::Key < ApplicationRecord
  broadcasts_refreshes

  self.primary_key = :id

  has_secure_password

  # generate client id
  before_validation do
    if id.blank?
      id = SecureRandom.uuid

      while Api::Key.exists?(id)
        id = SecureRandom.uuid
      end

      self.id = id
    end
  end

  before_validation do
    self.password = SecureRandom.base64(54) unless password_digest.present?
  end
end
