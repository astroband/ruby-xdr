module XDR::Concerns::ConvertsToXDR
  include XDR::Concerns::ReadsBytes
  
  def to_xdr(val)
    StringIO.
      new.
      tap{|io| write(val, io)}.
      string.force_encoding("ASCII-8BIT")
  end

  def write(val, io)
    raise NotImplementedError, "implement in including class"
  end
  
  def from_xdr(string)
    io = StringIO.new(string)
    read(io)
  end

  def read(io)
    raise NotImplementedError, "implement in including class"
  end

  private
  def padding_for(length)
    case length % 4
    when 0 ; 0
    when 1 ; 3
    when 2 ; 2
    when 3 ; 1
    end
  end
end