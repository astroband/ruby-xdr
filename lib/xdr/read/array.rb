class XDR::Read::Array
  include XDR::Reader

  def initialize(element_reader, length)
    @element_reader = element_reader
    @length         = length
  end

  def read(io)
    @length.times.map{ @element_reader.read(io) }
  end
end