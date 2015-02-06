class XDR::Array
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(type, length)
    @type   = type
    @length = length
  end

  def write(val, io)
    @length.times do |i|
      @type.write val[i], io
    end
  end

  def read(io)
    @length.times.map{ @type.read(io) }
  end
end