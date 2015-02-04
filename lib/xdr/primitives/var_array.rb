class XDR::Primitives::VarArray < XDR::Primitives::Base
  DEFAULT_MAX = 2**32 - 1

  def initialize(element_reader, max=DEFAULT_MAX)
    @element_reader = element_reader
    @max = max
  end

  def from_xdr(io)
    length = XDR::Primitives::INT.from_xdr(io)
    raise XDR::ReadError if length > @max

    length.times.map{ @element_reader.from_xdr(io) }
  end
end