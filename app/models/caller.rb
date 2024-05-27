class Caller < ApplicationRecord
  include Hookable

  def call!
    r = HTTParty.get(url)

    if r.code >= 200 && r.code < 300
      return true
    end

    false
  end
end
