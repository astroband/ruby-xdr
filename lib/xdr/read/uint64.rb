class XDR::Read::Uint64
  include XDR::Reader

  def read(io)
    read_bytes(io, 8).unpack("Q>").first
  end
end