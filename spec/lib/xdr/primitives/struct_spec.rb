require 'spec_helper'

describe XDR::Primitives::Struct, "#read" do
  subject{ XDR::Primitives::Struct.new(XDR::Primitives::INT, XDR::Primitives::INT) }

  it "decodes values correctly" do
    expect( read "\x00\x00\x00\x00\x00\x00\x00\x00" ).to eq([0,0])
    expect( read "\x00\x00\x00\x01\x00\x00\x00\x00" ).to eq([1,0])
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end