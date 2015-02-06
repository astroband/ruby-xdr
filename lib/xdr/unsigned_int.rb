module XDR::UnsignedInt
  extend XDR::Concerns::ConvertsToXDR

  def self.write(val, io)
    # TODO: check bounds
    io.write [val].pack("L>")
  end

  def self.read(io)
    read_bytes(io, 4).unpack("L>").first
  end
end