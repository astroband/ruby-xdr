class XDR::Primitives::String < XDR::Primitives::VarOpaque 
  def read(io)
    super(io).tap do |bytes|
      bytes.force_encoding("ASCII")
    end
  end
end