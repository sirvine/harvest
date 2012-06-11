class Hash
  def assert_valid_keys(*valid_keys)
    invalid_keys = valid_keys - [:email, :password, :sub_domain, :headers, :ssl]
    #raise ArgumentError, "Invalid key(s): #{invalid_keys.join(", ")} / Passed key(s): #{keys.join(", ")} / Valid key(s): #{valid_keys.join(", ")}" unless invalid_keys.empty?

    unless invalid_keys.empty?
      raise ArgumentError, "Invalid keys: #{invalid_keys.join(", ")} / Valid keys: #{valid_keys.join(", ")}"
    end
  end

  def assert_required_keys(*required_keys)
    missing_keys = required_keys.select {|key| !keys.include?(key)}
    raise ArgumentError, "Missing required option(s): #{missing_keys.join(", ")}" unless missing_keys.empty?
  end
end
