module Expirable::Advisor
  extend ActiveSupport::Concern
  include ActiveSupport::Inflector
  ADVISE_AT = [:day, :week, :month]

  included do
    enum :expiry_advised, ADVISE_AT.map { |v| [v, v.to_s] }.to_h.merge({none: "none", expired: "expired"}), default: :none, prefix: :expiry_advised
    before_save do |e|
      if e.expires_at_changed?
        e.expiry_advised = :none
      end
    end

    delegate :expiry_enabled?, :expiry_disabled?, to: :class
  end

  def advisory
    if expiry_disabled?
      return nil
    end

    if expired?
      return build_advisory(:expired)
    end

    ADVISE_AT.each do |a|
      if advise?(a)
        return build_advisory(a)
      end
    end

    nil
  end

  class_methods do
    def expiry_disabled=(block)
      @@expiry_disabled = block
    end

    def expiry_disabled?
      @@expiry_disabled.call
    end

    def expiry_enabled?
      !@@expiry_disabled.call
    end
  end

  private

  def build_advisory(type)
    safe_constantize(camelize("expirable/advisory/" + type.to_s)).new(self) unless expiry_advised.to_sym == type.to_sym
  end

  def advise?(time)
    expires_at.to_time <= Time.zone.tomorrow + 1.send(time)
  end
end
