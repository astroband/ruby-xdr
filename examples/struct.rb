require 'xdr'

class Envelope < XDR::Struct
  attribute :signature, XDR::Opaque[32]
  attribute :body,      XDR::VarOpaque[]
end

env = Envelope.new()
env.signature = "\x00" * 32
env.body = "Hello"
env.to_xdr
