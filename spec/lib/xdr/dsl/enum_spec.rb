require 'spec_helper'


describe XDR::DSL::Enum, "#member" do

  it "adds to the members collection of the class"
  it "raises ArgumentError if a non-fixnum value is used"

end

describe XDR::DSL::Enum, "#seal" do

  it "marks the class as sealed"
  it "prevents you from adding members after being sealed"

end