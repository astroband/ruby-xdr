require 'spec_helper'

describe XDR::Primitives::Union, "#read" do
  let(:type_map){{
    0        => XDR::Primitives::INT32,
    1        => XDR::Primitives::INT64,
    :default => XDR::Primitives::String.new()
  }}

  subject{ XDR::Primitives::Union.new(type_map) }

  it "decodes values correctly" do
    expect( read "\x00\x00\x00\x00\x00\x00\x00\x01" ).to eq([0,1])
    expect( read "\x00\x00\x00\x01\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF" ).to eq([1,-1])
    expect( read "\x00\x00\x00\x03\x00\x00\x00\x04hiya" ).to eq([:default,"hiya"])
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end