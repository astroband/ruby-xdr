module XDR::Bool
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::BOOL
  end
end