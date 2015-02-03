require 'spec_helper'

describe XDR::Primitives::Bool, "#read" do
  let(:false_s) {  "\x00\x00\x00\x00" }
  let(:true_s)  {  "\x00\x00\x00\x01" }
  let(:two)     {  "\x00\x00\x00\x02" }

  it "decodes values correctly" do
    expect(read(false_s)).to eq(false)
    expect(read(true_s)).to eq(true)
  end

  it "raises ReadError if the decoded value is not 0 or 1" do
    expect{ read two }.to raise_error XDR::ReadError
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end