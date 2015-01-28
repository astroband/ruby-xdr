class XDR::Read::Array
  include XDR::Reader

  def initialize(element_reader)
    @element_reader = element_reader
  end

  def read(io)
    length = XDR::Read::INT32.read(io)
    length.times.map{ @element_reader.read(io) }
  end
end