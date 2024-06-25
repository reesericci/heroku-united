module Extensibility
  extend ActiveSupport::Concern

  included do
    has_many :extensions, dependent: :destroy, as: :extensible
    accepts_nested_attributes_for :extensions, allow_destroy: false

    after_initialize do
      (Extension.names || {}).keys.each do |e|
        if extensions.find_by(name: e).blank?
          ext = extensions.new(name: e, content: "")
          if persisted?
            begin
              ext.save!
            rescue
              Rails.logger.warn("Unable to save new extension")
            end
          end
        end
      end
    end
  end
end
