class Hash
  def assert_valid_keys(*valid_keys)
    original_keys = keys.map{|key| key}
    nonvalid_keys = (original_keys - valid_keys)
    raise ArgumentError, "Invalid key(s): #{nonvalid_keys.join(", ")} | #{original_keys - valid_keys} / Passed key(s): #{original_keys.join(", ")} / Valid key(s): #{valid_keys.join(", ")}" unless nonvalid_keys.empty?
  end

  def assert_required_keys(*required_keys)
    missing_keys = required_keys.select {|key| !keys.include?(key)}
    raise ArgumentError, "Missing required option(s): #{missing_keys.join(", ")}" unless missing_keys.empty?
  end
end
