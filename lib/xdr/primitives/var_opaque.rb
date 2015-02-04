class XDR::Primitives::VarOpaque < XDR::Primitives::Base
  DEFAULT_MAX = 2**32 - 1

  def initialize(max=DEFAULT_MAX)
    @max = max
  end

  def to_xdr(val, io)
    length = val.bytesize
    raise XDR::WriteError, "Value length #{length} exceeds max #{@max}" if length > @max

    XDR::Primitives::INT.to_xdr(length, io)
    io.write val
    io.write "\x00" * padding_for(length)
  end

  def from_xdr(io)
    length = XDR::Primitives::INT.from_xdr(io)
    raise XDR::ReadError if length > @max
    padding = padding_for length

    # read and return length bytes
    # throw away padding bytes
    read_bytes(io, length).tap{ read_bytes(io, padding) }
  end
end