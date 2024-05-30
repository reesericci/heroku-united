module Imprintable
  extend ActiveSupport::Concern

  included do
    has_one :imprint, dependent: :destroy, autosave: true, as: :imprintable
    after_save_commit do
      if imprint.blank?
        create_imprint!
      end
    end
  end
end
