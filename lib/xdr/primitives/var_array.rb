class XDR::Primitives::VarArray < XDR::Primitives::Base
  DEFAULT_MAX = 2**32 - 1

  def initialize(element_reader, max=DEFAULT_MAX)
    @element_reader = element_reader
    @max = max
  end

  def read(io)
    length = XDR::Primitives::INT32.read(io)
    raise XDR::ReadError if length > @max

    length.times.map{ @element_reader.read(io) }
  end
end