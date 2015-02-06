module XDR::Hyper
  extend XDR::Concerns::ConvertsToXDR

  def self.write(val, io)
    # TODO: check bounds
    io.write [val].pack("q>")
  end

  def self.read(io)
    read_bytes(io, 8).unpack("q>").first
  end
end