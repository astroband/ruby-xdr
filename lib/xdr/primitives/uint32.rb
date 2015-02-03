class XDR::Primitives::Uint32 < XDR::Primitives::Base

  def from_xdr(io)
    read_bytes(io, 4).unpack("L>").first
  end
end