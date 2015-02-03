class XDR::Primitives::Void < XDR::Primitives::Base

  def from_xdr(io)
    nil
  end
end