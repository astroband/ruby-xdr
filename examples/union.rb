require 'xdr'

module ResultType
  include XDR::Enum
  OK       = 0
  ERROR    = 1
  NONSENSE = 2
end

class Result < XDR::Union
  switch_on ResultType, :type

  switch ResultType::OK
  switch ResultType::ERROR, :message
  switch :default, :void

  attribute :message, XDR::String[]
end

r = Result.new()
r.set(:error, "hello")
r.message! # => "hello"
r.get # => "hello"

r.set(:ok)
r.get # => nil

r.set(:nonsense)
r.get # => nil


# TODO
case r
when ResultType::OK ; puts "i'm ok!"
when ResultType::ERROR ; puts "broken!"
end