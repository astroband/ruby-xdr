class XDR::Struct
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  extend XDR::Concerns::ConvertsToXDR
  extend XDR::DSL::Struct

  class_attribute :fields
  self.fields = ActiveSupport::OrderedHash.new

  validates_with XDR::StructValidator

  def self.xdr_serializer
    # TODO: raise if `struct` aint an `XDR::Struct`
    return @xdr_serializer if defined? @xdr_serializer
    field_converters = self.fields.values.map(&:xdr_serializer)
    @xdr_serializer = XDR::Primitives::Struct.new(*field_converters)
  end

  def to_xdr
    self.class.to_xdr self
  end
end