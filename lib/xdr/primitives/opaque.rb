class XDR::Primitives::Opaque < XDR::Primitives::Base

  def initialize(length)
    @length  = length
    @padding = padding_for length
  end

  def read(io)
    # read and return @length bytes
    # throw away @padding bytes
    read_bytes(io, @length).tap{ read_bytes(io, @padding) }
  end
end