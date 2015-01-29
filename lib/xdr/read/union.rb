class XDR::Read::Union
  include XDR::Reader

  def initialize(type_map)
    @type_map = type_map
  end

  def read(io)
    discriminant = XDR::Read::INT32.read(io)
    arm = @type_map[discriminant]
    
    if arm.blank?
      discriminant = :default
      arm = @type_map[discriminant]
    end

    raise XDR::ReadError, "Invalid dscriminant: #{discriminant}" if arm.blank?

    [discriminant, arm.read(io)]
  end
end