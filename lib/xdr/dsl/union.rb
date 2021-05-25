module XDR::DSL::Union
  def switch_on(type, name)
    raise ArgumentError if switch_type.present?
    self.switch_type = type
    self.switch_name = name

    alias_method name, :switch
  end

  def switch(switch, arm = nil)
    raise ArgumentError, "`switch_on` not defined yet" if switch_type.nil?

    switch = normalize_switch_declaration(switch)
    self.switches = switches.merge(switch => arm)
  end

  def attribute(name, type)
    raise ArgumentError, "#{type} does not convert to xdr" unless type.is_a?(XDR::Concerns::ConvertsToXDR)

    self.arms = arms.merge(name => type)
    define_attribute_methods name
  end

  private

  def normalize_switch_declaration(switch)
    if switch.is_a?(switch_type)
      switch
    elsif switch_type.valid?(switch)
      switch
    elsif switch == :default
      switch
    elsif switch_type.respond_to?(:from_name)
      switch_type.from_name(switch)
    else
      raise ArgumentError, "Cannot normalize switch: #{switch.inspect} to type: #{switch_type}"
    end
  end
end
