class XDR::Primitives::UnsignedHyper < XDR::Primitives::Base
  def to_xdr(val, io)
    # TODO: check bounds
    io.write [val].pack("Q>")
  end

  def from_xdr(io)
    read_bytes(io, 8).unpack("Q>").first
  end
end