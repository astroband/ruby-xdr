#
# A thin wrapper around ActiveSupport::Autoload configured to always eager_load
# a child.  By calling `load_all!` on the namespace module, all children will
# be eager loaded, allowing us to more easily operate in a multi-threaded
# environment.
#
module XDR::Namespace
  extend ActiveSupport::Concern

  included do
    extend ActiveSupport::Autoload
  end

  module ClassMethods
    def load_all!
      constants.each do |const_name|
        const = const_get const_name
        const.public_send :load_all! if const.respond_to? :load_all!
      rescue NameError => e
        raise e unless /uninitialized constant #{const_name}/.match?(e.message)
      end
    end
  end
end
