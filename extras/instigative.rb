module Instigative
  def triggers
    
  end

  private

  def trigger(slug, name)
    class_eval <<-CODE, __FILE__, __LINE__ + 1
      @_#{slug}_trigger = Trigger.new name, slug, self

      def self.fire_#{slug}!
        @_#{slug}_trigger.fire!
      end

      def fire_#{slug}!
        Member.instance_variable_get(:@_#{slug}_trigger).fire!
      end
    CODE
  end
end
