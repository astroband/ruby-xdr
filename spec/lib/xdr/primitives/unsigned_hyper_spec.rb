require 'spec_helper'


describe XDR::Primitives::UnsignedHyper, "#read" do

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00\x00\x00\x00\x00")).to eq(0)
    expect(read("\x00\x00\x00\x00\x00\x00\x00\x01")).to eq(1)
    expect(read("\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF")).to eq(2**64 - 1)
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end