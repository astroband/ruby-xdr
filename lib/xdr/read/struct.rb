class XDR::Read::Struct
  include XDR::Reader

  def initialize(*fields)
    @fields = fields
  end

  def read(io)
    @fields.map{|f| f.read(io) }
  end
end