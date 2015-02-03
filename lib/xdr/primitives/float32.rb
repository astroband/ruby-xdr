class XDR::Primitives::Float32 < XDR::Primitives::Base

  def from_xdr(io)
    read_bytes(io, 4).unpack("g").first
  end
end