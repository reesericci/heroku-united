class Member < ApplicationRecord
  include Bannable
  include Expirable
  broadcasts_refreshes

  after_destroy_commit do
    broadcast_refresh_to :members
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  self.primary_key = "username"

  store :auxillary, accessors: [ :mxid ], coder: JSON, prefix: false

  def status
    if banned?
      return "banned"
    elsif expired?
      return "expired"
    else
      return "active"
    end
  end

  def self.where_active
    select do |m|
      !m.expired? && !m.banned?
    end
  end

end
