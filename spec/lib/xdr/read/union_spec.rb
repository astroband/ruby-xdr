require 'spec_helper'

describe XDR::Read::Union, "#read" do
  let(:type_map){{
    0        => XDR::Read::INT32,
    1        => XDR::Read::INT64,
    :default => XDR::Read::String.new()
  }}

  subject{ XDR::Read::Union.new(type_map) }

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