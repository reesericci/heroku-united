class Member < ApplicationRecord
  include Expirable
  include Renewable
  include Keycode::Imprintor
  include Mortality
  include Extensibility

  include SpreadsheetArchitect

  validates :username, format: {with: /\A[a-z0-9]+\z/i}

  def spreadsheet_columns
    [
      :username,
      :name,
      :pronouns,
      :email,
      ["Line 1", address&.line1],
      ["Line 2", address&.line2],
      ["City", address&.city],
      ["Province", address&.province],
      ["Code", address&.code],
      ["Country", address&.country.to_s]
    ] +
      (Extension.names || {}).keys.map { |e| [(e.present? ? ActiveSupport::Inflector.humanize(e) : ""), extensions.find_by(name: e)&.content] } +
      [:expires_at, :created_at, :updated_at, :banned]
  end

  # Addressable concern wasn't working
  has_one :address, dependent: :destroy, autosave: true, as: :addressable
  accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank

  broadcasts_refreshes

  after_destroy_commit do
    broadcast_refresh_to :members
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: ::URI::MailTo::EMAIL_REGEXP}, uniqueness: {case_sensitive: false}
  validates :name, presence: true

  before_validation do
    self.email = email.downcase
    self.username = username.downcase
  end

  self.primary_key = "username"

  self.condition = "membership"

  self.renew_location = "#{Config.external_url}/kiosk"

  expiry_disabled do
    Config.membership_length < 0
  end

  has_many :access_grants,
    class_name: "Doorkeeper::AccessGrant",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
    class_name: "Doorkeeper::AccessToken",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # or :destroy if you need callbacks

  def status
    if deceased?
      "deceased"
    elsif banned?
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
