module XDR::UnsignedHyper
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::UNSIGNED_HYPER
  end

  extend self
end