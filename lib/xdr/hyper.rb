module XDR::Hyper
  extend XDR::Concerns::ConvertsToXDR

  def self.xdr_serializer
    XDR::Primitives::HYPER
  end
end