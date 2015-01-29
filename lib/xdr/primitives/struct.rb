class XDR::Primitives::Struct < XDR::Primitives::Base

  def initialize(*fields)
    @fields = fields
  end

  def read(io)
    @fields.map{|f| f.read(io) }
  end
end