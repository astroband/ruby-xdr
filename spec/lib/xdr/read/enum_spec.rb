require 'spec_helper'

ZERO = "\x00\x00\x00\x00"
ONE  = "\x00\x00\x00\x01"
TWO  = "\x00\x00\x00\x02"

describe XDR::Read::Enum, "#read" do

  subject{ XDR::Read::Enum.new(0,1) }

  it "decodes values correctly" do
    expect(read(ZERO)).to eq(0)
    expect(read(ONE)).to eq(1)
  end

  it "raises EnumValueError if the decoded value is not in the defined constants" do
    expect{ read TWO }.to raise_error XDR::EnumValueError
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end