```xdr

enum CLFType {
    LIVEENTRY,
    DEADENTRY
};

struct CLFEntry
{
    Hash hash;
    union switch (CLFType type)
    {
        case LIVEENTRY:
            LedgerEntry liveEntry;

        case DEADENTRY:
            LedgerKey deadEntry;
    } entry;
};
```

becomes:

```ruby
module CLFType
  LIVEENTRY = 0
  DEADENTRY = 1
end


class CLFEntry
  include XDR::Struct

  class Entry
    include XDR::Union

    arm :live_entry, CLFType::LIVEENTRY, LedgerEntry
    arm :dead_entry, CLFType::DEADENTRY, LedgerKey
  end

  attribute :hash, Hash
  attribute :entry, CLFEntry::Entry
end


```