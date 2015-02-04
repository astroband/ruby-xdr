module XDR::Int
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::INT
  end
end