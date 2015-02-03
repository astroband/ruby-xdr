
class XDR::Primitives::Base
  include XDR::Concerns::ReadsBytes

  def to_xdr(io, val)
    raise NotImplementedError, "implement in subclass"
  end

  def from_xdr(io)
    raise NotImplementedError, "implement in subclass"
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