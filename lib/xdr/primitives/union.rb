class XDR::Primitives::Union < XDR::Primitives::Base

  def initialize(type_map)
    @type_map = type_map
  end

  def from_xdr(io)
    discriminant = XDR::Primitives::INT32.from_xdr(io)
    arm = @type_map[discriminant]
    
    if arm.blank?
      discriminant = :default
      arm = @type_map[discriminant]
    end

    raise XDR::ReadError, "Invalid dscriminant: #{discriminant}" if arm.blank?

    [discriminant, arm.from_xdr(io)]
  end
end