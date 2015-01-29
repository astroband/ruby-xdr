module XDR::Read
  extend ActiveSupport::Autoload

  autoload :Int32
  autoload :Uint32
  autoload :Int64
  autoload :Uint64
  autoload :Enum
  autoload :Bool
  autoload :Float32
  autoload :Float64
  autoload :Float128
  autoload :Opaque
  autoload :VarOpaque
  autoload :String
  autoload :Array
  autoload :VarArray

  # Primitive readers
  INT32    = Int32.new
  UINT32   = Uint32.new
  INT64    = Int64.new
  UINT64   = Uint64.new
  BOOL     = Bool.new
  FLOAT32  = Float32.new
  FLOAT64  = Float64.new
  FLOAT128 = Float128.new
end
