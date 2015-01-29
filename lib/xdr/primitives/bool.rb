class XDR::Primitives::Bool < XDR::Primitives::Base

  def read(io)
    value = XDR::Primitives::INT32.read(io)
    case value
    when 0 ; false
    when 1 ; true
    else ; raise XDR::ReadError, "Invalid bool value: #{value}"
    end
  end
end