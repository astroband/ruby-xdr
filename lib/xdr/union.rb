class XDR::Union
  extend XDR::Concerns::ConvertsToXDR
  extend XDR::DSL::Union

  class_attribute :arms
  class_attribute :switches
  class_attribute :switch_type
  class_attribute :switch_name
  attr_reader :switch
  attr_reader :arm

  self.arms = ActiveSupport::OrderedHash.new
  self.switches = ActiveSupport::OrderedHash.new
  self.switch_type = nil
  self.switch_name = nil

  def self.arm_for_switch(switch)
    begin
      switch = normalize_switch switch
    rescue ArgumentError => e
      raise XDR::InvalidSwitchError, e.message
    end

    result = switches.fetch(switch, :switch_not_found)
    result = switches.fetch(:default, :switch_not_found) if result == :switch_not_found

    if result == :switch_not_found
      raise XDR::InvalidSwitchError, "Bad switch: #{switch}"
    end

    result
  end

  def self.normalize_switch(switch)
    if switch.is_a?(switch_type)
      switch
    elsif switch_type.valid?(switch)
      switch
    elsif switch_type.respond_to?(:from_name)
      switch_type.from_name(switch)
    else
      raise ArgumentError, "Cannot normalize switch: #{switch.inspect} to type: #{switch_type}"
    end
  end

  def self.read(io)
    switch = switch_type.read(io)
    arm = arm_for_switch(switch)
    arm_type = arms[arm] || XDR::Void
    value = arm_type.read(io)
    new(switch, value)
  end

  def self.write(val, io)
    switch_type.write(val.switch, io)
    arm_type = arms[val.arm] || XDR::Void
    arm_type.write(val.get, io)
  end

  def self.valid?(val)
    val.is_a?(self)
  end

  def initialize(switch = :__unset__, value = :void)
    @switch = nil
    @arm = nil
    @value = nil
    set(switch, value) unless switch == :__unset__
  end

  #
  # Serializes struct to xdr, return a string of bytes
  #
  # @param format [:raw, :hex, :base64] The encoding used for the bytes produces, one of (:raw, :hex, :base64)
  #
  # @return [String] The encoded bytes of this struct
  def to_xdr(format = :raw)
    self.class.to_xdr(self, format)
  end

  def set(switch, value = :void)
    @switch = self.class.normalize_switch switch
    @arm = self.class.arm_for_switch @switch

    raise XDR::InvalidValueError unless valid_for_arm_type(value, @arm)

    @value = value
  rescue XDR::EnumNameError
    raise XDR::InvalidSwitchError, "Bad switch: #{switch}"
  end

  def value
    @value unless @value == :void
  end

  alias_method :get, :value

  def method_missing(method)
    is_bang = method.end_with?("!")
    attr = method.to_s.delete_suffix("!")

    super unless self.class.arms.key?(attr.to_sym)

    if @arm.to_s != attr
      return nil unless is_bang
      raise XDR::ArmNotSetError, "#{attr} is not the set arm"
    end

    get
  end

  def respond_to_missing?(method, *)
    attr = method.to_s.delete_suffix("!")

    self.class.arms.key?(attr.to_sym) || super
  end

  #
  # Compares two unions for equality
  #
  def ==(other)
    return false unless other.is_a?(self.class)
    return false unless other.switch == switch
    other.value == value
  end

  def eql?(other)
    return false unless other.is_a?(self.class)
    return false unless other.switch.eql? switch
    other.value.eql? value
  end

  def hash
    [self.class, switch, value].hash
  end

  private

  def valid_for_arm_type(value, arm)
    arm_type = arms[@arm]

    return value == :void if arm_type.nil?

    arm_type.valid?(value)
  end
end
