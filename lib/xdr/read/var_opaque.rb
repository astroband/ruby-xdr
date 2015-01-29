class XDR::Read::VarOpaque
  include XDR::Reader
  DEFAULT_MAX = 2**32 - 1

  def initialize(max=DEFAULT_MAX)
    @max = max
  end

  def read(io)
    length = XDR::Read::INT32.read(io)
    raise XDR::ReadError if length > @max
    padding = padding_for length

    # read and return length bytes
    # throw away padding bytes
    read_bytes(io, length).tap{ read_bytes(io, padding) }
  end
end