```xdr

typedef opaque uint256[32];

struct MyStruct
{
    unsigned int anInt;
    unsigned int *optionalInt;
    uint256  aHash;
};

```

becomes:

```ruby
Uint256 = XDR::Opaque[32]

class MyStruct
  include XDR::Struct

  attribute :an_int,       XDR::UnsignedInt
  attribute :optional_int, XDR::Option[XDR::UnsignedInt]
  attribute :a_hash,       Uint256
end
```