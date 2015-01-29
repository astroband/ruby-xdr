module XDR::Read
  extend ActiveSupport::Autoload

  autoload :Int32
  autoload :Uint32
  autoload :Int64
  autoload :Uint64
  autoload :Array

  # Primitive readers
  INT32  = Int32.new
  UINT32 = Uint32.new
  INT64  = Int64.new
  UINT64 = Uint64.new
end
