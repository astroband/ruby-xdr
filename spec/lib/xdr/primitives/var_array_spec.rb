require 'spec_helper'

describe XDR::Primitives::VarArray, "#read" do
  let(:empty_array) { "\x00\x00\x00\x00" }
  let(:one_array) { "\x00\x00\x00\x01\x00\x00\x00\x00" }
  let(:many_array) { "\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x02" }

  subject{ XDR::Primitives::VarArray.new(XDR::Primitives::INT, 3) }

  it "decodes values correctly" do
    expect(read(empty_array)).to eq([])
    expect(read(one_array)).to eq([0])
    expect(read(many_array)).to eq([0,1,2])
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end