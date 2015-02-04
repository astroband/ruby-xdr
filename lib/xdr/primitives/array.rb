class XDR::Primitives::Array < XDR::Primitives::Base

  def initialize(element_reader, length)
    @element_reader = element_reader
    @length         = length
  end

  def to_xdr(val, io)
    @length.times do |i|
      @element_reader.to_xdr val[i], io
    end
  end

  def from_xdr(io)
    @length.times.map{ @element_reader.from_xdr(io) }
  end
end