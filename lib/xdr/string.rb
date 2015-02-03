class XDR::String
  include XDR::Concerns::ConvertsToXDR

  def self.[] (max_length)
    new(max_length)
  end

  def initialize(max_length)
    @max_length = max_length
  end

  def xdr_serializer
    XDR::Primitives::String.new(@max_length)
  end
end