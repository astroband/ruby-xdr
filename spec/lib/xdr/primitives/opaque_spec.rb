require 'spec_helper'


describe XDR::Primitives::Opaque, "#read" do
  subject{ XDR::Primitives::Opaque.new(3) }

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq("\x00\x00\x00")
    expect(read("\x00\x01\x00\x00")).to eq("\x00\x01\x00")
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end