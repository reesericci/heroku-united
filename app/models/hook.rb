class Hook < ApplicationRecord
  delegated_type :hookable, types: %w[Caller Courier], dependent: :destroy
  delegate :call!, to: :hookable
end
