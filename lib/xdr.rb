require "xdr/version"
require "active_support/dependencies/autoload"

module XDR
  extend ActiveSupport::Autoload

  autoload :Reader
  autoload :Read
end
