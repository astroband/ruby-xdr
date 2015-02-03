class XDR::Primitives::Float64 < XDR::Primitives::Base

  def from_xdr(io)
    read_bytes(io, 8).unpack("G").first
  end
end