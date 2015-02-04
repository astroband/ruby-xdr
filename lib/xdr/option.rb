class XDR::Option
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(child_type)
    #TODO, raise an error if child_type is not ConvertToXDR
    @child_type = child_type
  end

  def xdr_serializer
    return @xdr_serializer if defined? @xdr_serializer

    @xdr_serializer = XDR::Primitives::Option.new(child_type.xdr_serializer)
  end
end