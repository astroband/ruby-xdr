module XDR::Double
  extend XDR::Concerns::ConvertsToXDR

  def self.write(val, io)
    raise XDR::WriteError unless val.is_a?(Float)
    io.write [val].pack("G")
  end

  def self.read(io)
    read_bytes(io, 8).unpack("G").first
  end
end