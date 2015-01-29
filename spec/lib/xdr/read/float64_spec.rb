require 'spec_helper'


describe XDR::Read::Float64, "#read" do

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00\x00\x00\x00\x00")).to eq(0.0)
    expect(read("\x80\x00\x00\x00\x00\x00\x00\x00")).to eq(-0.0)
    expect(read("\x3F\xF0\x00\x00\x00\x00\x00\x00")).to eq(1.0)
    expect(read("\xBF\xF0\x00\x00\x00\x00\x00\x00")).to eq(-1.0)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end