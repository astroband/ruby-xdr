class XDR::Primitives::String < XDR::Primitives::VarOpaque 

  def to_xdr(val)
    super val.encode("ASCII")
  end

  def from_xdr(io)
    super(io).tap do |bytes|
      bytes.force_encoding("ASCII")
    end
  end
end