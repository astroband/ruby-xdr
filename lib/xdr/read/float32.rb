class XDR::Read::Float32
  include XDR::Reader

  def read(io)
    read_bytes(io, 4).unpack("g").first
  end
end