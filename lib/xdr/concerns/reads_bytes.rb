module XDR::Concerns::ReadsBytes
  private
  def read_bytes(io, length)
    io.read(length).tap do |bytes|
      raise EOFError if bytes.nil? || bytes.length != length
    end
  end

  def write_bytes(io, content)
    io.write(content)
    content
  end
end