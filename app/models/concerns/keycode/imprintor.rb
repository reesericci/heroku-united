module Keycode::Imprintor
  extend ActiveSupport::Concern

  included do
    has_one :keycode_imprint, dependent: :destroy, autosave: true, as: :imprintor, class_name: "Keycode::Imprint"
    accepts_nested_attributes_for :keycode_imprint, allow_destroy: false
    after_save_commit do
      if keycode_imprint.blank?
        create_keycode_imprint!
      end
    end
  end
end
