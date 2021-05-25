require "base64"

class XDR::Struct
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  extend XDR::Concerns::ConvertsToXDR
  extend XDR::DSL::Struct

  attribute_method_prefix "read_"
  attribute_method_suffix "write_"

  class_attribute :fields
  self.fields = ActiveSupport::OrderedHash.new

  validates_with XDR::StructValidator

  attr_reader :attributes

  def self.read(io)
    new.tap do |result|
      fields.each do |name, type|
        result.public_send("#{name}=", type.read(io))
      end
    end
  end

  def self.write(val, io)
    fields.each do |name, type|
      field_val = val.public_send(name)
      type.write(field_val, io)
    end
  end

  def self.valid?(val)
    val.is_a?(self)
  end

  def initialize(attributes = {})
    @attributes = {}
    super
  end

  #
  # Serializes struct to xdr, return a string of bytes
  #
  # @param format [:raw, :hex, :base64] The encoding used for the bytes produces, one of (:raw, :hex, :base64)
  #
  # @return [String] The encoded bytes of this struct
  def to_xdr(format = :raw)
    raw = self.class.to_xdr(self)

    case format
    when :raw then raw
    when :hex then raw.unpack1("H*")
    when :base64 then Base64.strict_encode64(raw)
    else
      raise ArgumentError, "Invalid format #{format.inspect}; must be :raw, :hex, or :base64"
    end
  end

  #
  # Compares two structs for equality
  #
  def ==(other)
    return false unless other.is_a?(self.class)
    other.attributes == attributes
  end

  def eql?(other)
    return false unless other.is_a?(self.class)
    other.attributes.eql? attributes
  end

  def hash
    [self.class, attributes].hash
  end

  def read_attribute(attr)
    @attributes[attr]
  end

  def write_attribute(attr, value)
    @attributes[attr] = value
  end
end
