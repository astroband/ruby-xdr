require 'spec_helper'


describe XDR::Primitives::String, "#read" do
  subject{ XDR::Primitives::String.new(3) }

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq("")
    expect(read("\x00\x00\x00\x01h\x00\x00\x00")).to eq("h")
    expect(read("\x00\x00\x00\x02hi\x00\x00")).to eq("hi")
  end

  it "raises a ReadError when the encoded length is greater than the allowed max" do
    expect{ read "\x00\x00\x00\x04hiya" }.to raise_error(XDR::ReadError)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end