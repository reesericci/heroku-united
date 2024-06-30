module Renewable
  extend ActiveSupport::Concern
  include Payable

  def renew
    if renewable?
      update!(expires_at: expires_at + Config.membership_length.days)
      expires_at
    else
      raise "Unable to renew your membership"
    end
  end

  def renewable?
    # TODO: customizable renewal periods
    expires_at.to_time <= Time.zone.tomorrow + 1.month && !banned? && expiry_enabled?
  end

  class_methods do
    def renew_location
      @renew_location ||= "http://example.com"
    end

    private

    def renew_location=(value)
      @renew_location = value
    end
  end
end
