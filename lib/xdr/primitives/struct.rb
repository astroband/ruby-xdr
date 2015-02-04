class XDR::Primitives::Struct < XDR::Primitives::Base
  def initialize(*fields)
    @fields = fields
  end

  def to_xdr(val, io)
    @fields.each_with_index do |field, i|
      name = val.fields.keys[i]
      field.to_xdr(val.public_send(name), io)
    end
  end

  def from_xdr(io)
    @fields.map{|f| f.from_xdr(io) }
  end
end