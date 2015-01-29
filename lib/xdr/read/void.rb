class XDR::Read::Void
  include XDR::Reader

  def read(io)
    nil
  end
end