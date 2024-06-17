module Keycode::Imprintor
  extend ActiveSupport::Concern

  included do
    has_one :keycode_imprint, dependent: :destroy, autosave: true, as: :imprintor, class_name: "Keycode::Imprint"
    after_save_commit do
      if imprint.blank?
        create_imprint!
      end
    end
  end
end
