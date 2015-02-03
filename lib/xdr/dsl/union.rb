module XDR::DSL::Union
  def switch_on(type)
  end

  def switch(discriminant, arm)
    puts "switch #{discriminant} => #{arm}"
  end

  def arm(name, type)
    puts "arm #{name} => #{type}"
  end
end