module XDR::UnsignedInt
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::UNSIGNED_INT
  end
end