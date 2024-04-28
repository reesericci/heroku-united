module Bannable
  extend ActiveSupport::Concern

  def ban
    self.banned = true
  end

  def ban!
    update(banned: true)
  end

  def unban
    self.banned = false
  end

  def unban!
    update(banned: false)
  end
end
