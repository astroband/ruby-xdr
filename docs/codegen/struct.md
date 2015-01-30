```xdr

typedef opaque uint256[32];

struct MyStruct
{
    unsigned anInt;
    unsigned *optionalInt;
    uint256  aHash
};

```

becomes:

```ruby
Uint256 = XDR::Opaque[32]

class MyStruct
  include XDR::Struct

  attribute :an_int,       XDR::Unsigned
  attribute :optional_int, XDR::Option[XDR::Unsigned]
  attribute :a_hash,       Uint256
end
```
example usage:

```ruby

entry = MyStruct.new  # => raise RequiredFieldNotSetError
entry = MyStruct.new(an_int: 100, a_hash: "\x00...")
entry.an_int # => 100
entry.an_int = 200
entry.an_int # => 200
entry.an_int = nil  # => raise RequiredFieldError

entry.optional_int? # => false
entry.optional_int # => nil
entry.optional_int = 100
entry.optional_int? # => true
entry.optional_int # => 100

```