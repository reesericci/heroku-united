class Trigger
  attr_accessor :name, :slug, :instigator

  # TODO: add a way in dev server to refresh these if changed
  def initialize(n, s, instigator)
    @name = n
    @slug = s
    @instigator = instigator

    Rails.application.trigger = self
  end

  def fire!
    hooks.find_each { |h| h.call! }
  end

  def hooks
    Hook.where(trigger_id: id)
  end

  def id
    (instigator.name + "_" + slug.to_s).downcase.to_sym
  end

  def self.all
    Rails.application.triggers
  end
end
