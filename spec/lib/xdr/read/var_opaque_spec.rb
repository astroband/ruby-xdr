require 'spec_helper'


describe XDR::Read::VarOpaque, "#read" do
  subject{ XDR::Read::VarOpaque.new(6) }

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq("")
    expect(read("\x00\x00\x00\x01\x00\x00\x00\x00")).to eq("\x00")
    expect(read("\x00\x00\x00\x01\x01\x00\x00\x00")).to eq("\x01")
    expect(read("\x00\x00\x00\x02\x00\x01\x00\x00")).to eq("\x00\x01")
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end