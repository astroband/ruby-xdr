require "xdr/version"
require "active_support/dependencies/autoload"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/logger"

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

  mattr_accessor :logger
  self.logger = ActiveSupport::Logger.new(STDOUT)
  self.logger.level = Logger::WARN
end
