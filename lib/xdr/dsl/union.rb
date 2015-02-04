module XDR::DSL::Union
  def switch_on(type)
    raise ArgumentError if self.switch_type.present?
    self.switch_type = type
  end

  def switch(discriminant, arm)
    self.switches = self.switches.merge(discriminant => arm)
  end

  def attribute(name, type)
    raise ArgumentError, "#{type} does not convert to xdr" unless type.is_a?(XDR::Concerns::ConvertsToXDR)

    self.arms = self.arms.merge(name => type)
    define_attribute_methods name
  end
end