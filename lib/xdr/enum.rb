module XDR::Enum
  extend ActiveSupport::Concern

  included do
    extend XDR::Concerns::ConvertsToXDR 

    # NOTE: cannot include in ClassMethods because
    # it gets include before this block is run
    def self.xdr_serializer
      @xdr_serializer ||= XDR::Primitives::Enum.new(*members.values)
    end
  end

  module ClassMethods
    def members
      @members ||= constants(false).
        map{|n| [n, const_get(n)]}.
        to_h.
        with_indifferent_access
    end

    def from_name(name)
      normalized = name.to_s.underscore.upcase
      members[normalized].tap do |r|
        if r.blank?
          raise XDR::EnumNameError, "#{name} is not a member of #{self.name}"
        end
      end
    end
  end
end