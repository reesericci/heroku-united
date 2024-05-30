class Config < ApplicationRecord
  before_create :check_for_existing
  before_destroy :check_for_existing
  self.table_name = :configurations

  has_secure_password

  store :smtp, accessors: [:server, :port, :username, :password, :box, :domain], prefix: true

  before_validation do 
    self.email = self.email.downcase
  end

  def self.organization
    Config.first&.organization
  end

  def self.membership_length
    Config.first&.membership_length
  end

  def self.email
    Config.first&.email
  end

  def self.external_url
    Config.first&.external_url
  end

  private

  def check_for_existing
    raise ActiveRecord::RecordInvalid if Config.count >= 1
  end
end
