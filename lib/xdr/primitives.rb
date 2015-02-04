module XDR::Primitives
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Int
  autoload :UnsignedInt
  autoload :Hyper
  autoload :UnsignedHyper
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
  autoload :Struct
  autoload :Union
  autoload :Void

  # Primitive readers
  INT32    = Int.new
  UINT32   = UnsignedInt.new
  INT64    = Hyper.new
  UINT64   = UnsignedHyper.new
  BOOL     = Bool.new
  FLOAT32  = Float32.new
  FLOAT64  = Float64.new
  FLOAT128 = Float128.new
  VOID     = Void.new
end
