class XDR::Opaque
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(length)
    @length = length
  end

  def xdr_serializer
    XDR::Primitives::Opaque.new(@length)
  end
end