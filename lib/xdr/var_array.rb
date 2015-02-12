class XDR::VarArray
  include XDR::Concerns::ConvertsToXDR
  include XDR::Concerns::StringConverter

  singleton_class.send(:alias_method, :[], :new)

  def initialize(type, length=XDR::MAX_SIZE)
    @type   = type
    @length = length
  end

  def write(val, io)
    length = val.length

    if length > @length
      raise XDR::WriteError, "Value length #{length} exceeds max #{@length}"
    end

    XDR::Int.write(length, io)
    val.each do |member|
      @type.write member, io
    end
  end

  def read(io)
    length = XDR::Int.read(io)

    if length > @length
      raise XDR::ReadError, "VarArray length #{length} is greater than max #{@length}"
    end

    length.times.map{ @type.read(io) }
  end
end