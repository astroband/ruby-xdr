class XDR::Primitives::VarOpaque < XDR::Primitives::Base
  DEFAULT_MAX = 2**32 - 1

  def initialize(max=DEFAULT_MAX)
    @max = max
  end

  def to_xdr(val)
    length = val.bytesize
    raise XDR::WriteError, "Value length #{length} exceeds max #{@max}" if length > @max

    StringIO.new.tap do |out|
      out.write XDR::Primitives::INT32.to_xdr(length)
      out.write val
      out.write "\x00" * padding_for(length)
    end.string
  end

  def read(io)
    length = XDR::Primitives::INT32.read(io)
    raise XDR::ReadError if length > @max
    padding = padding_for length

    # read and return length bytes
    # throw away padding bytes
    read_bytes(io, length).tap{ read_bytes(io, padding) }
  end
end