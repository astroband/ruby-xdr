module XDR::Enum
  extend ActiveSupport::Concern

  included do
    extend XDR::Concerns::ConvertsToXDR 

    # NOTE: cannot include these methods in ClassMethods because
    # it gets include before this block is run, thus it wouldn't
    # override the abstract methods defined in ConvertsToXDR
    
    def self.write(val, io)
      found = valid_values.include?(val)
      raise XDR::WriteError, "Invalid enum value: #{val.inspect}" unless found

      XDR::Int.write(val, io)
    end

    def self.read(io)
      XDR::Int.read(io).tap do |val|
        found = valid_values.include?(val)
        raise XDR::EnumValueError, "Unknown #{name} member: #{val}" unless found
      end
    end
  end

  module ClassMethods
    def members
      @members ||= constants(false).
        map{|n| [n, const_get(n)]}.
        to_h.
        with_indifferent_access
    end

    def valid_values
      @values ||= Set.new(members.values)
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