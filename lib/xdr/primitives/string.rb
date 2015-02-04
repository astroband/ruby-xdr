class XDR::Primitives::String < XDR::Primitives::VarOpaque 

  def from_xdr(io)
    super(io).tap do |bytes|
      bytes.force_encoding("ASCII")
    end
  end
end