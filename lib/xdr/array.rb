class XDR::Array
  include XDR::Concerns::ConvertsToXDR

  singleton_class.send(:alias_method, :[], :new)

  def initialize(type, length)
    @type   = type
    @length = length
  end

  def write(val, io)
    raise XDR::WriteError, "val is not array" unless val.is_a?(Array)
    raise XDR::WriteError, "array must be #{@length} long, was #{val.length}" if val.length != @length

    @length.times do |i|
      @type.write val[i], io
    end
  end

  def read(io)
    @length.times.map{ @type.read(io) }
  end

  def valid?(val)
    val.is_a?(Array)
  end
end