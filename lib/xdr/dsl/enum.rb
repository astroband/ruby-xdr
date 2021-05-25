module XDR::DSL::Enum
  def member(name, value)
    name = name.to_s.underscore

    raise ArgumentError, "#{self} is sealed" if sealed
    raise ArgumentError, "#{value} is not Integer" unless value.is_a?(Integer)
    raise ArgumentError, "#{value} is already used" if members.key?(name)

    instance = new(name, value)
    self.members = members.merge(name => instance)
    self.by_value = by_value.merge(instance.value => instance)

    class_eval <<-EOS, __FILE__, __LINE__ + 1
      def self.#{name}
        members["#{name}"]
      end
    EOS
  end

  def seal
    self.sealed = true
  end
end
