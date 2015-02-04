class XDR::VarArray
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(type, length=XDR::MAX_SIZE)
    @type   = type
    @length = length
  end

  def xdr_serializer
    XDR::Primitives::VarArray.new(@type.xdr_serializer, @length)
  end
end