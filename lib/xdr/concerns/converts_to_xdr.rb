module XDR::Concerns::ConvertsToXDR
  def to_xdr(val, io=nil)
    if io.present?
      xdr_serializer.to_xdr(val, io)
    else
      StringIO.
        new.
        tap{|io| xdr_serializer.to_xdr(val, io)}.
        string
    end
  end

  def from_xdr(io)
    io = io.is_a?(String) ? StringIO.new(io) : io

    xdr_serializer.from_xdr(io)
  end

  def xdr_serializer
    raise NotImplementedError, "implement in including class"
  end
end