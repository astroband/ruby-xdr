module XDR::Bool
  include XDR::Concerns::ConvertsToXDR

  def converter
    XDR::Primitives::BOOL
  end

  extend self
end