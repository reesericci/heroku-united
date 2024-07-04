module Exportable
  include ActiveSupport::Inflector

  def export(type)
    constantize(camelize("export/#{type}")).new(self)
  end
end
