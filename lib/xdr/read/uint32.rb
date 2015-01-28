class XDR::Read::Uint32
  include XDR::Reader

  def read(io)
    read_bytes(io, 4).unpack("L>").first
  end
end