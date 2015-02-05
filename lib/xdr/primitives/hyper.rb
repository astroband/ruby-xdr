class XDR::Primitives::Hyper < XDR::Primitives::Base
  def to_xdr(val, io)
    # TODO: check bounds
    io.write [val].pack("q>")
  end

  def from_xdr(io)
    read_bytes(io, 8).unpack("q>").first
  end
end