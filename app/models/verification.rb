class Verification < ApplicationRecord
  belongs_to :verifiable, polymorphic: true

  before_save do
    if verified_at.blank?
      self.verified_at = DateTime.now
    end
  end
end
