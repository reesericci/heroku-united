module Renewer
  extend ActiveSupport::Concern

  def renew
    @@renewable.call(request).renew
    redirect_back fallback_location: root_path, status: 303
  end

  class_methods do
    def renewable(&block)
      @@renewable = block
    end
  end
end
