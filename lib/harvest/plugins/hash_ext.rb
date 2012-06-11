class Hash
  def assert_valid_keys(*valid_keys)
    original_keys = keys.map{|key| key}
    invalid_keys = original_keys - valid_keys
    raise ArgumentError, "Invalid key(s): #{invalid_keys.join(", ")} | #{invalid_keys.class.name} / Passed key(s): #{original_keys.join(", ")} | #{original_keys.class.name} / Valid key(s): #{valid_keys.join(", ")} | #{valid_keys.class.name}" unless invalid_keys.empty?
  end

  def assert_required_keys(*required_keys)
    missing_keys = required_keys.select {|key| !keys.include?(key)}
    raise ArgumentError, "Missing required option(s): #{missing_keys.join(", ")}" unless missing_keys.empty?
  end
end
