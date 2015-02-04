class XDR::String
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)
  
  def initialize(max_length=XDR::MAX_SIZE)
    @max_length = max_length
  end

  def xdr_serializer
    XDR::Primitives::String.new(@max_length)
  end
end