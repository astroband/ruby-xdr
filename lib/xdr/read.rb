module XDR::Read
  extend ActiveSupport::Autoload

  autoload :Int32
  autoload :Uint32
  autoload :Array

  # Primitive readers
  INT32  = Int32.new
  UINT32 = Uint32.new
end
