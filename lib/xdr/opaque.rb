class XDR::Opaque
  def self.[] (length)
    new(length)
  end

  def initialize(length)
    @length = length
  end

  def valid?(input)
    input.is_a?(String) && input.length == @length
  end

end