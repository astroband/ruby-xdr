class XDR::Primitives::Union < XDR::Primitives::Base

  def initialize(type_map)
    @type_map = type_map
  end

  def read(io)
    discriminant = XDR::Primitives::INT32.read(io)
    arm = @type_map[discriminant]
    
    if arm.blank?
      discriminant = :default
      arm = @type_map[discriminant]
    end

    raise XDR::ReadError, "Invalid dscriminant: #{discriminant}" if arm.blank?

    [discriminant, arm.read(io)]
  end
end