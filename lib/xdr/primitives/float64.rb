class XDR::Primitives::Float64 < XDR::Primitives::Base

  def read(io)
    read_bytes(io, 8).unpack("G").first
  end
end