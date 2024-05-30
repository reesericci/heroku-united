class Imprint < ApplicationRecord
  belongs_to :imprintable, polymorphic: true

  after_save_commit do
    if base.blank?
      update!(base: ROTP::Base32.random, coded_at: DateTime.now)
    end
  end

  def code
    Imprint::Code.new(self)
  end
end

class Imprint::Code
  def initialize(imprint)
    @imprint = imprint
  end

  def hotp
    ROTP::HOTP.new(@imprint.base)
  end

  def create!
    @imprint.update!(count: @imprint.count + 1, coded_at: DateTime.now, used: false)
    self
  end

  def to_i
    hotp.at(@imprint.count).to_i
  end

  def to_s
    hotp.at(@imprint.count).to_s
  end

  def ==(other)
    if other.respond_to?(:to_s)
      to_s == other.to_s
    elsif other.respond_to?(:to_i)
      to_i == other.to_i
    else
      false
    end
  end

  def ===(other)
    if other.is_a?(Imprint::Code)
      if other.instance_variable_get(:@imprint) == @imprint
        other.to_i == to_i
      else
        false
      end
    else
      false
    end
  end

  def authenticate!(other)
    if other == self && !@imprint.used?
      @imprint.update!(used: true)
      true
    else
      false
    end
  end

  alias_method :to_str, :to_s

  def expired?
    DateTime.now.after?(@imprint.coded_at + 10.minutes) || @imprint.used?
  end
end
