require 'spec_helper'

EMPTY_ARRAY = "\x00\x00\x00\x00"
ONE_ARRAY   = "\x00\x00\x00\x01\x00\x00\x00\x00"
MANY_ARRAY  = "\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x02"

describe XDR::Read::Array, "#read" do

  subject{ XDR::Read::Array.new(XDR::Read::INT32) }

  it "decodes values correctly" do
    expect(read(EMPTY_ARRAY)).to eq([])
    expect(read(ONE_ARRAY)).to eq([0])
    expect(read(MANY_ARRAY)).to eq([0,1,2])
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end