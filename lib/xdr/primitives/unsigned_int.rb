class XDR::Primitives::UnsignedInt < XDR::Primitives::Base
  def to_xdr(val, io)
    # TODO: check bounds
    io.write [val].pack("L>")
  end
  
  def from_xdr(io)
    read_bytes(io, 4).unpack("L>").first
  end
end