module XDR::Concerns::ConvertsToXDR
  include XDR::Concerns::ReadsBytes

  # 
  # Serialized the provided `val` to xdr and writes it to `io`
  # 
  # @param val [Object] The object to serialize
  # @param io [IO] an IO object to write to
  # 
  def write(val, io)
    raise NotImplementedError, "implement in including class"
  end

  # 
  # Reads from the provided IO an instance of the implementing class
  # @param io [IO] the io to read from
  # 
  # @return [Object] the deserialized value
  def read(io)
    raise NotImplementedError, "implement in including class"
  end

  # 
  # Returns true if the value provided is compatible with this serializer class
  # 
  # @param value [Object] the value to test
  # 
  # @return [Boolean] true if valid, false otherwise
  def valid?(value)
    raise NotImplementedError, "implement in including class"
  end
  
  # 
  # Serialized the provided val to xdr, returning a string
  # of the serialized data
  # 
  # @param val [Object] the value to serialize
  # 
  # @return [String] the produced bytes
  def to_xdr(val)
    StringIO.
      new.
      tap{|io| write(val, io)}.
      string.force_encoding("ASCII-8BIT")
  end
  
  # 
  # Deserializes an object from the provided string of bytes
  # 
  # @param string [String] the bytes to read from
  # 
  # @return [Object] the deserialized value
  def from_xdr(string)
    io = StringIO.new(string)
    read(io)
  end

  private
  def padding_for(length)
    case length % 4
    when 0 ; 0
    when 1 ; 3
    when 2 ; 2
    when 3 ; 1
    end
  end
end