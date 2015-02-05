class XDR::Union
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  extend XDR::Concerns::ConvertsToXDR
  extend XDR::DSL::Union


  class_attribute :arms
  class_attribute :switches
  class_attribute :switch_type
  class_attribute :switch_name
  attr_reader     :switch

  self.arms        = ActiveSupport::OrderedHash.new
  self.switches    = ActiveSupport::OrderedHash.new
  self.switch_type = nil
  self.switch_name = nil

  attribute_method_suffix '!'

  validates_with XDR::UnionValidator


  def initialize(switch=nil, value=:void)
    @switch   = nil
    @arm      = nil
    @value    = nil
    set(switch, value) if switch
  end

  def self.arm_for_switch(switch)
    switches.fetch(switch, :switch_not_found).tap do |s|
      if s == :switch_not_found
        raise XDR::InvalidSwitchError, "Bad switch: #{switch.inspect}"
      end
    end
  end

  def self.xdr_serializer
    return @xdr_serializer if defined? @xdr_serializer

    type_map = switches.map do |k,v| 
      arm_type       = arms[arm_for_switch(k)]
      arm_serializer = arm_type.xdr_serializer if arm_type.present?
      [k, arm_serializer]
    end.to_h


    @xdr_serializer = XDR::Primitives::Union.new(type_map)
  end

  def to_xdr
    self.class.to_xdr self
  end

  def set(switch=nil, value=:void)
    @switch   = switch_type.from_name(switch)
    @arm      = self.class.arm_for_switch @switch

    raise XDR::InvalidArmError unless valid_for_arm_type(value, @arm)

    @value = value
  end

  def get
    @value
  end

  def attribute!(attr)
    if @arm.to_s != attr
      raise XDR::ArmNotSetError, "#{attr} is not the set arm"
    end

    get
  end

  private


  def valid_for_arm_type(value, arm)
    arm_type = arms[@arm]

    case arm_type
    when nil
      value == :void
    when XDR::Int, XDR::UnsignedInt, XDR::Hyper, XDR::UnsignedHyper ;
      value.is_a?(Fixnum)
    when XDR::Float, XDR::Double, XDR::Quadruple ;
      value.is_a?(Float)
    when XDR::String, XDR::Opaque, XDR::VarOpaque ;
      value.is_a?(String)
    when XDR::Array, XDR::VarArray ;
      value.is_a?(Array)
    when XDR::Bool ;
      value.is_a?(Boolean)
    when XDR::Option ;
      value.nil? || valid_for_arm_type(value, arm_type.child_type)
    else

      # if none of the above special cases, the value needs to be descendent
      # from the arm_type

      value.is_a?(arm_type)
    end
  end
end



