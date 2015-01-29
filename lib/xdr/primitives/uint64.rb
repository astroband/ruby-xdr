class XDR::Primitives::Uint64 < XDR::Primitives::Base

  def read(io)
    read_bytes(io, 8).unpack("Q>").first
  end
end