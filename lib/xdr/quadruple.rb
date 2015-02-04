module XDR::Quadruple
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::QUADRUPLE
  end
end