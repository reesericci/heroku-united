module Hookable
  extend ActiveSupport::Concern

  included do
    has_one :hook, as: :hookable, touch: true, dependent: :destroy
  end
end
