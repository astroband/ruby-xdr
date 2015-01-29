class XDR::Primitives::Enum < XDR::Primitives::Base

  def initialize(*constants)
    @constants = constants
  end

  def read(io)
    XDR::Primitives::INT32.read(io).tap do |value|
      found = @constants.index(value)
      raise XDR::EnumValueError unless found
    end
  end
end