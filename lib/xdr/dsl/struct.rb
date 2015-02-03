module XDR::DSL::Struct
  def attribute(name, type)

    raise ArgumentError, "#{type} does not convert to xdr" unless type.is_a?(XDR::Concerns::ConvertsToXDR)

    self.fields = self.fields.merge(name => type)

    attr_accessor name
    define_attribute_methods name
  end
end