require 'spec_helper'

describe XDR::Read::Array, "#read" do
  let(:empty){ XDR::Read::Array.new(XDR::Read::INT32, 0) }
  let(:one){ XDR::Read::Array.new(XDR::Read::INT32, 1) }
  let(:many){ XDR::Read::Array.new(XDR::Read::INT32, 2) }

  it "decodes values correctly" do
    expect( read empty, "" ).to eq([])
    expect( read empty, "\x00\x00\x00\x00" ).to eq([])
    expect( read one, "\x00\x00\x00\x00" ).to eq([0])
    expect( read one, "\x00\x00\x00\x01" ).to eq([1])
    expect( read many, "\x00\x00\x00\x00\x00\x00\x00\x01" ).to eq([0, 1])
    expect( read many, "\x00\x00\x00\x01\x00\x00\x00\x01" ).to eq([1, 1])
  end

  it "raises EOFError the byte stream isn't large enough" do
    expect{ read many, "\x00\x00\x00\x00" }.to raise_error(EOFError)
  end

  def read(reader, str)
    io = StringIO.new(str)
    reader.read(io)
  end
end