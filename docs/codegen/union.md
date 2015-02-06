```xdr

enum MyUnionType {
  TYPE_1,
  TYPE_2,
  TYPE_3,
  TYPE_4
};

union MyUnion switch (MyUnionType type)
{
    case TYPE_1:
        hyper typeOneVal;

    case TYPE_2:
    case TYPE_3:
        int typeTwoVal;

    case TYPE_4:
        void;

    default:
        CustomType typeThreeVal;
};

```

becomes:

```ruby
module MyUnionType
  TYPE_1 = 0
  TYPE_2 = 1
  TYPE_3 = 2
  TYPE_4 = 3
end

class MyUnion < XDR::Union

  switch_on :type, MyUnionType

  switch MyUnionType::TYPE_1, :type_one_val
  switch MyUnionType::TYPE_2, :type_two_val
  switch MyUnionType::TYPE_3, :type_two_val
  switch MyUnionType::TYPE_4 # void
  switch :default, :type_three_val # default

  attribute :type_one_val,    XDR::Hyper
  attribute :type_two_val,    XDR::Int
  attribute :type_three_val,  CustomType
end
```