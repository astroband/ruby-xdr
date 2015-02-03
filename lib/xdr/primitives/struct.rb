class XDR::Primitives::Struct < XDR::Primitives::Base

  def initialize(*fields)
    @fields = fields
  end

  def to_xdr(val)
    StringIO.new.tap do |out|
      # write the length
      out.write XDR::Primitives::INT32.to_xdr(val.fields.length)

      # write the fields
      val.
        fields.
        map{|n,v| v.to_xdr(val.public_send n)}.
        each{|xdr| out.write(xdr)}
    end.string
  end

  def from_xdr(io)
    @fields.map{|f| f.from_xdr(io) }
  end
end