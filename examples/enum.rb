require 'xdr'

module Color
  include XDR::Enum

  RED   = 0
  GREEN = 1
  BLUE  = 2
end

Color.members           # => {:RED => 0, :GREEN => 1, :BLUE => 2}
Color.members.keys      # => [:RED, :GREEN, :BLUE]
Color.from_name(:RED)   # => 0
Color.from_name("RED")  # => 0

Color.from_xdr("\x00\x00\x00\x00") # => 0
Color.to_xdr(1) # => "\x00\x00\x00\x01"