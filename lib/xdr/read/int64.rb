class XDR::Read::Int64
  include XDR::Reader

  def read(io)
    read_bytes(io, 8).unpack("q>").first
  end
end