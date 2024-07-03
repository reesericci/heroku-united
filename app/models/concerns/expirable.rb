module Expirable
  extend ActiveSupport::Concern
  include Expirable::Advisor

  def expired?
    expires_at&.< DateTime.now unless expiry_disabled?
  end

  def self.find_each(&block)
    ActiveRecord::Base.descendants.select { |c| c.included_modules.include?(Expirable) }.each do |model|
      model.find_each(&block)
    end
  end

  class_methods do
    def condition
      @condition ||= "Thing™"
    end

    def expired
      select { |e| e.expired? }
    end

    private

    def condition=(value)
      @condition = value
    end
  end
end
