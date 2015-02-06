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


class CLFEntry < XDR::Struct

  class Entry < XDR::Union
    switch_on CLFType

    switch CLFType::LIVEENTRY, :live_entry
    switch CLFType::DEADENTRY, :dead_entry

    attribute :live_entry, LedgerEntry
    attribute :dead_entry, LedgerKey
  end

  attribute :hash, Hash
  attribute :entry, CLFEntry::Entry
end


```