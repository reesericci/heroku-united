class Export
  include ActiveSupport::Inflector

  def initialize(relation)
    @relation = relation
  end

  def to_data
    raise "override in subclass!"
  end

  def filename
    "#{parameterize(Time.zone.now.iso8601).upcase}-#{parameterize(Config.organization)}-#{parameterize(pluralize(demodulize(@relation.model)))}-#{parameterize(demodulize(self.class.name))}"
  end
end
