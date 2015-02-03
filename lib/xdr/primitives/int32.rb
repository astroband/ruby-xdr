class XDR::Primitives::Int32 < XDR::Primitives::Base
  def to_xdr(val)
    # TODO: check bounds
    [val].pack("l>")
  end

  def read(io)
    read_bytes(io, 4).unpack("l>").first
  end
end