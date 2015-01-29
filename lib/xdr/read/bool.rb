class XDR::Read::Bool
  include XDR::Reader

  def read(io)
    value = XDR::Read::INT32.read(io)
    case value
    when 0 ; false
    when 1 ; true
    else ; raise XDR::ReadError, "Invalid bool value: #{value}"
    end
  end
end