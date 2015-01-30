require "xdr/version"
require "active_support/dependencies/autoload"
require "active_support/core_ext/object/blank"

module XDR
  extend ActiveSupport::Autoload

  autoload :Primitives
  autoload :RPC

  module Concerns
    extend ActiveSupport::Autoload
    autoload :ReadsBytes
  end

  class Error < StandardError ; end
  class ReadError < Error ; end
  class EnumValueError < ReadError ; end
end
