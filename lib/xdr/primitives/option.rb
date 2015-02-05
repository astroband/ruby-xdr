class XDR::Primitives::Option < XDR::Primitives::Base
  def initialize(child_type)
    @child_type = child_type
  end

  def to_xdr(val, io)
    if val.present?
      XDR::Primitives::INT.to_xdr(1, io)
      @child_type.to_xdr(val, io)
    else
      XDR::Primitives::INT.to_xdr(0, io)
    end
  end

  def from_xdr(io)
    present = XDR::Primitives::INT.from_xdr(io) > 0
    @child_type.from_xdr(io) if present
  end
end