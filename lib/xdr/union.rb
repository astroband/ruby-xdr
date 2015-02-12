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
  attr_reader     :arm

  self.arms        = ActiveSupport::OrderedHash.new
  self.switches    = ActiveSupport::OrderedHash.new
  self.switch_type = nil
  self.switch_name = nil

  attribute_method_suffix '!'

  def self.arm_for_switch(switch)
    raise XDR::InvalidSwitchError unless switch.is_a?(switch_type)

    result = switches.fetch(switch, :switch_not_found)
    result = switches.fetch(:default, :switch_not_found) if result == :switch_not_found

    if result == :switch_not_found
      raise XDR::InvalidSwitchError, "Bad switch: #{switch}"
    end

    result
  end

  def self.read(io)
    switch   = switch_type.read(io)
    arm      = arm_for_switch(switch)
    arm_type = arms[arm] || XDR::Void
    value    = arm_type.read(io)
    new(switch, value)
  end

  def self.write(val, io)
    switch_type.write(val.switch, io)
    arm_type = arms[val.arm] || XDR::Void
    arm_type.write(val.get,io)
  end

  def self.valid?(val)
    val.is_a?(self)
  end

  def initialize(switch=nil, value=:void)
    @switch   = nil
    @arm      = nil
    @value    = nil
    set(switch, value) if switch
  end

  def to_xdr
    self.class.to_xdr self
  end

  def set(switch, value=:void)
    @switch = switch.is_a?(switch_type) ? switch : switch_type.from_name(switch)
    @arm    = self.class.arm_for_switch @switch

    raise XDR::InvalidValueError unless valid_for_arm_type(value, @arm)

    @value = value
  rescue XDR::EnumNameError
    raise XDR::InvalidSwitchError, "Bad switch: #{switch}"
  end

  def value
    @value unless @value == :void
  end

  alias get value

  def attribute!(attr)
    if @arm.to_s != attr
      raise XDR::ArmNotSetError, "#{attr} is not the set arm"
    end

    get
  end

  private
  def valid_for_arm_type(value, arm)
    arm_type = arms[@arm]

    return value == :void if arm_type.nil?

    arm_type.valid?(value)
  end
end



