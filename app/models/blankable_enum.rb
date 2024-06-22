module BlankableEnum
  def assert_valid_enum_definition_values(values)
    case values
    when Hash
      # if values.empty?
      #   raise ArgumentError, "Enum values #{values} must not be empty."
      # end

      if values.keys.any?(&:blank?)
        raise ArgumentError, "Enum values #{values} must not contain a blank name."
      end
    when Array
      # if values.empty?
      #   raise ArgumentError, "Enum values #{values} must not be empty."
      # end

      unless values.all?(Symbol) || values.all?(String)
        raise ArgumentError, "Enum values #{values} must only contain symbols or strings."
      end

      if values.any?(&:blank?)
        raise ArgumentError, "Enum values #{values} must not contain a blank name."
      end
    else
      raise ArgumentError, "Enum values #{values} must be either a non-empty hash or an array."
    end
  end
end
