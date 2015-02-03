class XDR::Primitives::Enum < XDR::Primitives::Base

  def initialize(*constants)
    @constants = constants
  end

  def from_xdr(io)
    XDR::Primitives::INT32.from_xdr(io).tap do |value|
      found = @constants.index(value)
      raise XDR::EnumValueError unless found
    end
  end
end