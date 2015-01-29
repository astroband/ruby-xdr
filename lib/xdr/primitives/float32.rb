class XDR::Primitives::Float32 < XDR::Primitives::Base

  def read(io)
    read_bytes(io, 4).unpack("g").first
  end
end