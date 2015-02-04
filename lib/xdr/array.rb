class XDR::Array
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(type, length)
    @type   = type
    @length = length
  end

  def xdr_serializer
    XDR::Primitives::Array.new(@type.xdr_serializer, @length)
  end
end