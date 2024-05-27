Rails.application.class_eval <<-CODE, __FILE__, __LINE__ + 1
  attr_reader :triggers

  def trigger=(trigger)
    @triggers = (@triggers ||= Hash.new)
    @triggers[trigger.id.to_sym] = trigger
  end
CODE
