class XDR::Primitives::Array < XDR::Primitives::Base

  def initialize(element_reader, length)
    @element_reader = element_reader
    @length         = length
  end

  def from_xdr(io)
    @length.times.map{ @element_reader.from_xdr(io) }
  end
end