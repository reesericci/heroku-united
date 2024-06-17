class Keycode::Imprint < ApplicationRecord
  self.table_name = "keycode_imprints"

  belongs_to :imprintor, polymorphic: true

  after_save_commit do
    if base.blank?
      update!(base: ROTP::Base32.random, coded_at: DateTime.now)
    end
  end

  def code
    Keycode.new(self)
  end
end
