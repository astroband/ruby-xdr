require 'spec_helper'


describe XDR::Void, ".read" do

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq(:void)
    expect(read("\x00\x00\x00\x01")).to eq(:void)
    expect(read("\xFF\xFF\xFF\xFF")).to eq(:void)
    expect(read("\x7F\xFF\xFF\xFF")).to eq(:void)
    expect(read("\x80\x00\x00\x00")).to eq(:void)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end