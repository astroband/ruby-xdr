class XDR::Read::Float64
  include XDR::Reader

  def read(io)
    read_bytes(io, 8).unpack("G").first
  end
end