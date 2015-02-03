require 'spec_helper'

describe XDR::Primitives::Enum, "#read" do
  let(:zero) { "\x00\x00\x00\x00" }
  let(:one) { "\x00\x00\x00\x01" }
  let(:two) { "\x00\x00\x00\x02" }

  subject{ XDR::Primitives::Enum.new(0,1) }

  it "decodes values correctly" do
    expect( read zero ).to eq(0)
    expect( read one ).to eq(1)
  end

  it "raises EnumValueError if the decoded value is not in the defined constants" do
    expect{ read two }.to raise_error XDR::EnumValueError
  end

  def read(str)
    io = StringIO.new(str)
    subject.from_xdr(io)
  end
end