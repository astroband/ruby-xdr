class XDR::Primitives::Uint32 < XDR::Primitives::Base

  def read(io)
    read_bytes(io, 4).unpack("L>").first
  end
end