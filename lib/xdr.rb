require "xdr/version"
require "active_support/dependencies/autoload"
require "active_support/core_ext/object/blank"

module XDR
  extend ActiveSupport::Autoload

  autoload :Reader
  autoload :Read

  class Error < StandardError ; end
  class ReadError < Error ; end
  class EnumValueError < ReadError ; end
end
