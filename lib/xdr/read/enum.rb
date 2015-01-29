class XDR::Read::Enum
  include XDR::Reader

  def initialize(*constants)
    @constants = constants
  end

  def read(io)
    XDR::Read::INT32.read(io).tap do |value|
      found = @constants.index(value)
      raise XDR::EnumValueError unless found
    end
  end
end