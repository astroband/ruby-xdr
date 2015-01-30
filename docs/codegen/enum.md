```xdr
enum TransactionType
{
    PAYMENT,
    CREATE_OFFER,
    CANCEL_OFFER,
    SET_OPTIONS,
    CHANGE_TRUST,
    ALLOW_TRUST,
    ACCOUNT_MERGE,
    INFLATION
};
```

becomes:

```ruby
module TransactionType
  PAYMENT       = 0
  CREATE_OFFER  = 1
  CANCEL_OFFER  = 2
  SET_OPTIONS   = 3
  CHANGE_TRUST  = 4
  ALLOW_TRUST   = 5
  ACCOUNT_MERGE = 6
  INFLATION     = 7
end
```