require 'spec_helper'


describe XDR::Read::Opaque, "#read" do
  subject{ XDR::Read::Opaque.new(3) }

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq("\x00\x00\x00")
    expect(read("\x00\x01\x00\x00")).to eq("\x00\x01\x00")
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end