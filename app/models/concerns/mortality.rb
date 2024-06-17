module Mortality
  extend ActiveSupport::Concern

  included do
    default_scope { where(deceased: false) }
    scope :include_deceased, -> { unscope(where: :deceased) }
    scope :cemetery, -> { include_deceased.where(deceased: true) }
    alias_method :destroy!, :decease
    alias_method :destroy, :decease

    before_save do
      if deceased_changed?
        @transmigrating = true
      end
    end
  end

  def decease
    update!(deceased: true)
    self
  end

  def resurrect
    update!(deceased: false)
    self
  end

  def cremate!
    # Taken from ActiveRecord::Persistence
    # https://edgeapi.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-destroy

    destroy_associations
    @_trigger_destroy_callback ||= persisted? && destroy_row > 0
    @destroyed = true
    @previously_new_record = false
    freeze
  end

  def readonly?
    deceased? unless @transmigrating
  end
end
