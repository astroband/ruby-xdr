module XDR::Concerns::ConvertsToXDR
  def to_xdr(val)
    xdr_serializer.to_xdr(val)
  end

  def from_xdr(io)
    io = io.is_a?(String) ? StringIO.new(io) : io

    xdr_serializer.from_xdr(io)
  end

  def xdr_serializer
    raise NotImplementedError, "implement in including class"
  end
end