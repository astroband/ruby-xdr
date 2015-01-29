require 'spec_helper'


describe XDR::Primitives::Void, "#read" do

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq(nil)
    expect(read("\x00\x00\x00\x01")).to eq(nil)
    expect(read("\xFF\xFF\xFF\xFF")).to eq(nil)
    expect(read("\x7F\xFF\xFF\xFF")).to eq(nil)
    expect(read("\x80\x00\x00\x00")).to eq(nil)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end