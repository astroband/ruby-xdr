module XDR::Int
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::INT32
  end

  extend self
end