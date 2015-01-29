
module XDR::Reader
  private
  def read_bytes(io, length)
    io.read(length).tap do |bytes|
      raise EOFError if bytes.nil? || bytes.length != length
    end
  end

  def padding_for(length)
    case length % 4
    when 0 ; 0
    when 1 ; 3
    when 2 ; 2
    when 3 ; 1
    end
  end
end