class SymbolJSON
  def self.load(payload)
    Array.wrap(JSON.parse(payload)).map { |i| ActiveSupport::Inflector.parameterize(i, separator: "_").to_sym }.compact_blank
  end

  def self.dump(payload)
    JSON.generate(payload)
  end
end
