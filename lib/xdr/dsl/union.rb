module XDR::DSL::Union
  def switch_on(type, name)
    raise ArgumentError if self.switch_type.present?
    self.switch_type = type
    self.switch_name = name
  end

  def switch(switch, arm=nil)
    # TODO: confirm switch is a member of the switch_on enum
    self.switches = self.switches.merge(switch => arm)
  end

  def attribute(name, type)
    raise ArgumentError, "#{type} does not convert to xdr" unless type.is_a?(XDR::Concerns::ConvertsToXDR)

    self.arms = self.arms.merge(name => type)
    define_attribute_methods name
  end
end