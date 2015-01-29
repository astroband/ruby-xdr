class XDR::Primitives::Float128 < XDR::Primitives::Base

  # unfortunately, we can't depend upon String#unpack for float128 values
  
  def read(io)
    raise NotImplementedError
  end
end