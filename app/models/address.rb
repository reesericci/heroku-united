class Address < ApplicationRecord
  include Domesticable

  belongs_to :addressable, polymorphic: true

  validates :line1, :city, :province, presence: true
end
