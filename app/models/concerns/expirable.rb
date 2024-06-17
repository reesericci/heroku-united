module Expirable
  extend ActiveSupport::Concern

  included do
    enum :expiry_advised, {none: "none", month: "month", week: "week", day: "day", expired: "expired"}, default: :none, prefix: :expiry_advised
    before_save do |e|
      if e.expires_at_changed?
        e.expiry_advised = :none
      end
    end
  end

  def expired?
    expires_at&.< DateTime.now if expiry_enabled?
  end

  def day_only?
    expires_at.to_time <= Time.zone.tomorrow + 1.day if expiry_enabled?
  end

  def week_only?
    expires_at.to_time <= Time.zone.tomorrow + 1.week if expiry_enabled?
  end

  def month_only?
    expires_at.to_time <= Time.zone.tomorrow + 1.month if expiry_enabled?
  end

  def self.find_each(&block)
    ActiveRecord::Base.descendants.select { |c| c.included_modules.include?(Expirable) }.each do |model|
      model.find_each(&block)
    end
  end

  def expiry_enabled?
    self.class.expiry_enabled?
  end

  class_methods do
    def condition
      @condition ||= "Thing™"
    end

    def expiry_enabled?
      !@expiry_disabled.call
    end

    def expired
      select { |e| e.expired? }
    end

    private

    def condition=(value)
      @condition = value
    end

    def expiry_disabled(&block)
      @expiry_disabled = block || -> { false }
    end
  end
end
