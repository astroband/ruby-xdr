module XDR::Concerns::ReadsBytes
  private

  def read_bytes(io, length)
    io.read(length).tap do |bytes|
      raise EOFError if bytes.nil? || bytes.length != length
    end
  end

  def read_zeros(io, length)
    read_bytes(io, length).each_byte do |byte|
      raise XDR::ReadError unless byte == 0
    end

    nil
  end
end
