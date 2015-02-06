module XDR::Int
  extend XDR::Concerns::ConvertsToXDR

  def self.write(val, io)
    # TODO: check bounds
    io.write [val].pack("l>")
  end

  def self.read(io)
    read_bytes(io, 4).unpack("l>").first
  end
end