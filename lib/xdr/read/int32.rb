class XDR::Read::Int32
  include XDR::Reader

  def read(io)
    read_bytes(io, 4).unpack("l>").first
  end
end