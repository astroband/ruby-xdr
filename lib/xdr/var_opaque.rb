class XDR::VarOpaque
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(length=XDR::MAX_SIZE)
    @length = length
  end

  def xdr_serializer
    XDR::Primitives::VarOpaque.new(@length)
  end
end