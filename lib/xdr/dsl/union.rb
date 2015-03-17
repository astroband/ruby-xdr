module XDR::DSL::Union
  def switch_on(type, name)
    raise ArgumentError if self.switch_type.present?
    self.switch_type = type
    self.switch_name = name

    alias_method name, :switch
  end

  def switch(switch, arm=nil)
    raise ArgumentError, "`switch_on` not defined yet" if self.switch_type.nil?

    switch = normalize_switch(switch)
    self.switches = self.switches.merge(switch => arm)
  end

  def attribute(name, type)
    raise ArgumentError, "#{type} does not convert to xdr" unless type.is_a?(XDR::Concerns::ConvertsToXDR)

    self.arms = self.arms.merge(name => type)
    define_attribute_methods name
  end

  private
  def normalize_switch(switch)
    case switch
    when self.switch_type ; switch
    when :default ;         switch
    else ;                  self.switch_type.from_name(switch)
    end
  end
end