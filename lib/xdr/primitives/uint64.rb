class XDR::Primitives::Uint64 < XDR::Primitives::Base

  def from_xdr(io)
    read_bytes(io, 8).unpack("Q>").first
  end
end