module Expirable
  extend ActiveSupport::Concern

  included do
    scope :expired, -> { where "expires_at < NOW()" }
    enum :expiry_advised, {none: "none", month: "month", week: "week", day: "day", expired: "expired"}, default: :none, prefix: :expiry_advised
    before_save do |e|
      if e.expires_at_changed?
        e.expiry_advised = :none
      end
    end
  end

  def expired?
    expires_at&.< DateTime.now
  end

  def day_only?
    expires_at.to_time <= Time.zone.tomorrow + 1.day
  end

  def week_only?
    expires_at.to_time <= Time.zone.tomorrow + 1.week
  end

  def month_only?
    expires_at.to_time <= Time.zone.tomorrow + 1.month
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

    private

    def condition=(value)
      @condition = value
    end
  end
end
