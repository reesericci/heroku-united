module Bannable
  extend ActiveSupport::Concern
  
  def ban
    self.banned = true
  end

  def ban!
    self.update(banned: true)
  end

  def unban
    self.banned = false
  end

  def unban!
    self.update(banned: false)
  end
end