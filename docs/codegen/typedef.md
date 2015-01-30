```xdr
typedef opaque Signature[64];
typedef opaque Hash[32];
typedef opaque uint256[32];
typedef unsigned uint32;
typedef unsigned hyper uint64;
typedef opaque Value<>;
typedef opaque Evidence<>;

typedef unsigned *maybeUint32;
typedef uint32 *maybeAnotherUint32;
```

becomes:

```ruby
Signature = XDR::Opaque[64]
Hash      = XDR::Opaque[32]
Uint256   = XDR::Opaque[32]
Uint32    = XDR::Unsigned
Uint64    = XDR::UnsignedHyper
Value     = XDR::VarOpaque[]
Evidence  = XDR::VarOpaque[]

MaybeUint32        = XDR::Option[XDR::Unsigned]
MaybeAnotherUint32 = XDR::Option[Uint32]
```

