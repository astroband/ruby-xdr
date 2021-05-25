module XDR::Bool
  extend XDR::Concerns::ConvertsToXDR

  def self.write(val, io)
    case val
    when true then XDR::Int.write(1, io)
    when false then XDR::Int.write(0, io)
    else; raise XDR::WriteError, "Invalid bool value: #{val}"
    end
  end

  def self.read(io)
    val = XDR::Int.read(io)
    case val
    when 0 then false
    when 1 then true
    else; raise XDR::ReadError, "Invalid bool value: #{val}"
    end
  end

  def self.valid?(val)
    val == true || val == false
  end
end
