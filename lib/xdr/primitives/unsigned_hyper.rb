class XDR::Primitives::UnsignedHyper < XDR::Primitives::Base

  def from_xdr(io)
    read_bytes(io, 8).unpack("Q>").first
  end
end