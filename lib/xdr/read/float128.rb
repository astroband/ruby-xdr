class XDR::Read::Float128
  include XDR::Reader

  # unfortunately, we can't depend upon String#unpack for float128 values
  
  def read(io)
    raise NotImplementedError
  end
end