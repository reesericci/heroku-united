class Extension < ApplicationRecord
  belongs_to :extensible, polymorphic: true, optional: false
  enum :name, Config.extensions_enum, instance_methods: false
end
