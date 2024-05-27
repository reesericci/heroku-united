class Member < ApplicationRecord
  include Bannable
  include Expirable
  include Imprintable
  extend Instigative

  broadcasts_refreshes

  after_destroy_commit do
    broadcast_refresh_to :members
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: {case_sensitive: false}
  validates :name, presence: true

  before_validation do
    self.email = email.downcase
  end

  self.primary_key = "username"

  # TODO: proper auxillary fields

  store :auxillary, accessors: [:mxid], coder: JSON, prefix: false

  has_many :access_grants,
    class_name: "Doorkeeper::AccessGrant",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
    class_name: "Doorkeeper::AccessToken",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # or :destroy if you need callbacks
  trigger :join, "Join"
  # TODO: expiry cleanup job which fires trigger each day

  after_create_commit do
    fire_join!
  end

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

  def id
    username
  end
end
