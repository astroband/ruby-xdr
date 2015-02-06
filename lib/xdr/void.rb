module XDR::Void
  extend XDR::Concerns::ConvertsToXDR

  def self.write(val, io)
  end

  def self.read(io)
    :void
  end
end