class Extension < ApplicationRecord
  extend BlankableEnum
  belongs_to :extensible, polymorphic: true, optional: false
  enum :name, Config.extensions_enum, instance_methods: false, validate: {allow_nil: true}
end
