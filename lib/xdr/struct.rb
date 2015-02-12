class XDR::Struct
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  extend XDR::Concerns::ConvertsToXDR
  extend XDR::DSL::Struct

  class_attribute :fields
  self.fields = ActiveSupport::OrderedHash.new

  validates_with XDR::StructValidator

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

  def to_xdr
    self.class.to_xdr(self)
  end
end