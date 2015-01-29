class XDR::Read::String < XDR::Read::VarOpaque
  include XDR::Reader
 
  def read(io)
    super(io).tap do |bytes|
      bytes.force_encoding("ASCII")
    end
  end
end