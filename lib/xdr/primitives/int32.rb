class XDR::Primitives::Int32 < XDR::Primitives::Base

  def read(io)
    read_bytes(io, 4).unpack("l>").first
  end
end