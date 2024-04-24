module Expirable
  extend ActiveSupport::Concern
  
  def expired?
    if self.expires_at != nil
      self.expires_at < DateTime.now
    else
      false
    end
  end

  class_methods do
    def unexpired
      select do |m|
        if m.expires_at != nil
          m.expires_at.future?
        else
          true
        end
      end
    end

    def expired
      select do |m|
        if m.expires_at != nil
          m.expires_at.past?
        else
          false
        end
      end
    end
  end
end