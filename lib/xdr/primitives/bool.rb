class XDR::Primitives::Bool < XDR::Primitives::Base

  def from_xdr(io)
    value = XDR::Primitives::INT.from_xdr(io)
    case value
    when 0 ; false
    when 1 ; true
    else ; raise XDR::ReadError, "Invalid bool value: #{value}"
    end
  end
end