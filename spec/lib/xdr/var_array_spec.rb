require 'spec_helper'

describe XDR::VarArray, "#read" do
  let(:empty_array) { "\x00\x00\x00\x00" }
  let(:one_array) { "\x00\x00\x00\x01\x00\x00\x00\x00" }
  let(:many_array) { "\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x00" }
  let(:too_large_array) { "\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x02" }

  subject{ XDR::VarArray[XDR::Int, 2] }

  it "decodes values correctly" do
    expect(read(empty_array)).to eq([])
    expect(read(one_array)).to eq([0])
    expect(read(many_array)).to eq([3,0])
  end

  it "raises ReadError when the encoded array is too large" do
    expect{ read(too_large_array) }.to raise_error(XDR::ReadError)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end


describe XDR::VarArray, "#write" do

  subject{ XDR::VarArray[XDR::Int, 3] }

  it "encodes values correctly" do
    expect(write([])).to eq("\x00\x00\x00\x00")
    expect(write([7])).to eq("\x00\x00\x00\x01\x00\x00\x00\x07")
    expect(write([1,2,3])).to eq("\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03")
  end

  it "raises WriteError when the array to encode is too large" do
    expect{ write([0,1,2,3]) }.to raise_error(XDR::WriteError)
  end

  def write(val)
    io = StringIO.new
    subject.write(val,io)
    io.string
  end
end