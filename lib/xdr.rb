require "xdr/version"
require "active_support/dependencies/autoload"

module XDR
  extend ActiveSupport::Autoload

  autoload :Reader
  autoload :Read

  class Error < StandardError ; end
  class ReadError < Error ; end
  class EnumValueError < ReadError ; end
end
