class My
  include ActiveSupport::Delegation
  cattr_accessor :member

  class << self
    delegate_missing_to :member
    delegate :name, to: :member
  end
end
