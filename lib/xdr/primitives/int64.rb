class XDR::Primitives::Int64 < XDR::Primitives::Base

  def read(io)
    read_bytes(io, 8).unpack("q>").first
  end
end