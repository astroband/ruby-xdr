module XDR::DSL::Struct
  def attribute(name, type)

    unless type.is_a?(XDR::Concerns::ConvertsToXDR)
      raise ArgumentError, "#{type} does not convert to xdr" 
    end

    self.fields = self.fields.merge(name => type)

    attr_accessor name
    define_attribute_methods name
  end
end