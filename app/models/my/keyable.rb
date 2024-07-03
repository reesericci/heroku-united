module My::Keyable
  extend ActiveSupport::Concern

  included do
    has_one :keyring, as: :keyable, dependent: :destroy, class_name: "My::Keyring"
  end
end
