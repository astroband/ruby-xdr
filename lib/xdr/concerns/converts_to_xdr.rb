require "base64"

module XDR::Concerns::ConvertsToXDR
  include XDR::Concerns::ReadsBytes

  #
  # Serialized the provided `val` to xdr and writes it to `io`
  #
  # @abstract
  # @param val [Object] The object to serialize
  # @param io [#write] an IO object to write to
  # @return [void]
  def write(val, io)
    raise NotImplementedError, "implement in including class"
  end

  #
  # Reads from the provided IO an instance of the implementing class
  #
  # @abstract
  # @param io [#read] the io to read from
  # @return [Object] the deserialized value
  def read(io)
    raise NotImplementedError, "implement in including class"
  end

  # Returns true if the value provided is compatible with this serializer class
  #
  # @abstract
  # @param value [Object] the value to test
  # @return [Boolean] true if valid, false otherwise
  def valid?(value)
    raise NotImplementedError, "implement in including class"
  end

  # Serialized the provided val to xdr, returning a string
  # of the serialized data
  #
  # @param val [Object] the value to serialize
  # @param encoding [:raw|:hex|:base64] encode the result with specified codec
  # @return [String] the produced bytes
  def to_xdr(val, encoding = "raw")
    io = StringIO.new
    write(val, io)
    raw = io.string.force_encoding("ASCII-8BIT")

    case String(encoding)
    when "raw" then raw
    when "hex" then raw.unpack1("H*")
    when "base64" then Base64.strict_encode64(raw)
    else
      raise ArgumentError, "Invalid encoding #{encoding.inspect}: must be 'raw', 'base64', or 'hex'"
    end
  end

  # Deserializes an object from the provided string of bytes
  #
  # @param string [String] the bytes to read from
  # @param encoding [:raw|:hex|:base64] decode the input before deserialization
  # @return [Object] the deserialized value
  def from_xdr(string, encoding = "raw")
    raw = case String(encoding)
          when "raw" then string
          when "hex" then [string].pack("H*")
          when "base64" then Base64.strict_decode64(string)
          else
            raise ArgumentError, "Invalid encoding #{encoding.inspect}: must be 'raw', 'base64', or 'hex'"
    end

    io = StringIO.new(raw)
    result = read(io)

    if io.pos != io.length
      raise ArgumentError, "Input string not fully consumed! are you decoding the right xdr type?"
    end

    result
  end

  private

  def padding_for(length)
    case length % 4
    when 0 then 0
    when 1 then 3
    when 2 then 2
    when 3 then 1
    end
  end
end
