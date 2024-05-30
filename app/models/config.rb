class Config < ApplicationRecord
  before_create :check_for_existing
  before_destroy :check_for_existing
  self.table_name = :configurations

  has_secure_password

  store :smtp, accessors: [:server, :port, :username, :password, :box, :domain], prefix: true

  before_validation do
    self.email = email.downcase
  end

  after_save_commit do
    if oidc_key.blank?
      update!(oidc_key: OpenSSL::PKey::RSA.new(2048))
    end
    Doorkeeper::OpenidConnect.configuration.instance_variable_set(:@signing_key, oidc_key)
  end

  after_initialize do
    if Rails.application.credentials&.oidc&.[](:key) != oidc_key
      update!(oidc_key: Rails.application.credentials&.oidc&.[](:key))
    end
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

  def self.oidc_key
    Config.first&.oidc_key
  end

  private

  def check_for_existing
    raise ActiveRecord::RecordInvalid if Config.count >= 1
  end
end
