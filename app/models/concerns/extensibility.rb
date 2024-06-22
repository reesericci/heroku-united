module Extensibility
  extend ActiveSupport::Concern

  included do
    has_many :extensions, dependent: :destroy, as: :extensible
    accepts_nested_attributes_for :extensions, allow_destroy: false

    after_initialize do
      Extension.names.keys.each do |e|
        if extensions.find_by(name: e).blank?
          extensions.create!(name: e, content: "")
        end
      end
    end
  end
end
