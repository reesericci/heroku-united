class Keycode::Imprint < ApplicationRecord
  self.table_name = "keycode_imprints"

  belongs_to :imprintor, polymorphic: true

  after_save_commit do
    if base.blank?
      update!(base: ROTP::Base32.random, coded_at: DateTime.now)
    end
  end

  def hotp
    ROTP::HOTP.new(base)
  end

  def totp
    ROTP::TOTP.new(base, issuer: Config.organization || "United!")
  end

  def uri(user)
    totp.provisioning_uri(user)
  end

  def code
    Keycode.new(self)
  end

  def authenticate!(other)
    # ⛔️ references the void method, I thought it would be a fun surprise to use an emoji :P
    if (hotp.verify(other, count) || totp.verify(other, drift_behind: 5)) && !code.⛔️?
      update!(used: true)
      true
    else
      false
    end
  end

  def rotate!
    update!(base: ROTP::Base32.random, coded_at: DateTime.now)
  end

  class Keycode
    def initialize(imprint)
      @imprint = imprint
    end
  
    def rotate!
      @imprint.update!(count: @imprint.count + 1, coded_at: DateTime.now, used: false)
      self
    end
  
    def to_i
      @imprint.hotp.at(@imprint.count).to_i
    end
  
    def to_s
      @imprint.hotp.at(@imprint.count).to_s
    end
  
    alias_method :to_str, :to_s
  
    def void?
      DateTime.now.after?(@imprint.coded_at + 10.minutes) || @imprint.used?
    end
  
    alias_method :⛔️?, :void?
  end
end
