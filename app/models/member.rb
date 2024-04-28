class Member < ApplicationRecord
  include Bannable
  include Expirable
  broadcasts_refreshes

  after_destroy_commit do
    broadcast_refresh_to :members
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: {case_sensitive: false}
  validates :name, presence: true

  before_validation do 
    self.email = self.email.downcase
  end

  self.primary_key = "username"

  store :auxillary, accessors: [:mxid], coder: JSON, prefix: false

  def status
    if banned?
      "banned"
    elsif expired?
      "expired"
    else
      "active"
    end
  end

  def self.where_active
    select do |m|
      !m.expired? && !m.banned?
    end
  end
end
