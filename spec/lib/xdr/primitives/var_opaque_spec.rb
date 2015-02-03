require 'spec_helper'


describe XDR::Primitives::VarOpaque, "#read" do
  subject{ XDR::Primitives::VarOpaque.new(2) }

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq("")
    expect(read("\x00\x00\x00\x01\x00\x00\x00\x00")).to eq("\x00")
    expect(read("\x00\x00\x00\x01\x01\x00\x00\x00")).to eq("\x01")
    expect(read("\x00\x00\x00\x02\x00\x01\x00\x00")).to eq("\x00\x01")
  end

  it "raises a ReadError when the encoded length is greater than the allowed max" do
    expect{ read "\x00\x00\x00\x03\x00\x00\x00\x00" }.to raise_error(XDR::ReadError)
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end