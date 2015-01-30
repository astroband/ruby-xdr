```xdr

enum LedgerType {
    ACCOUNT,
    TRUSTLINE,
    OFFER
};

union LedgerEntry switch (LedgerType type)
{
    case ACCOUNT:
        AccountEntry account;

    case TRUSTLINE:
        TrustLineEntry trustLine;

    case OFFER:
        OfferEntry offer;
};

```

becomes:

```ruby
module LedgerType
  ACCOUNT   = 0
  TRUSTLINE = 1
  OFFER     = 2
end

class LedgerEntry
  include XDR::Union

  arm :account,    LedgerType::ACCOUNT,   AccountEntry
  arm :trust_line, LedgerType::TRUSTLINE, TrustLineEntry
  arm :offer,      LedgerType::OFFER,     OfferEntry
end
```

usage:

```ruby
LedgerEntry.new # => raise 

entry = LedgerEntry.new(:account, AccountEntry.new)
entry.arm # => 0
entry.get # => #<AccountEntry:...>
entry.account! # => #<AccountEntry:...>
entry.trust_line! # => raise ArmNotSetError

entry.set :trust_line, TrustLineEntry.new
entry.arm # => 1
entry.get # => #<TrustLineEntry:...>
entry.trust_line! # => #<TrustLineEntry:...>

```