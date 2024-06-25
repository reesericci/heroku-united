module Keycode::Imprint::Rotator
  extend ActiveSupport::Concern

  def rotate_imprint
    @@imprintor.call(request).keycode_imprint.rotate!
    redirect_back fallback_location: kiosk_member_path, status: 303
  end

  class_methods do
    def imprintor(&block)
      @@imprintor = block
    end
  end
end