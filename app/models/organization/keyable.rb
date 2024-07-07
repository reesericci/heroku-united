module Organization::Keyable
  extend ActiveSupport::Concern

  included do
    has_one :keyring, as: :keyable, dependent: :destroy, class_name: "Organization::Keyring"
  end

  class_methods do
    delegate :keyring, to: :first, allow_nil: true

    delegate :create_keyring, to: :first
  end
end
