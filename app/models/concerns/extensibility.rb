module Extensibility
  extend ActiveSupport::Concern

  included do
    has_many :extensions, dependent: :destroy, as: :extensible, autosave: true
    accepts_nested_attributes_for :extensions, allow_destroy: false

    after_initialize do
      extensions.each do |e|
        if e.content.blank?
          e.delete
        end
      end
    end
  end
end
