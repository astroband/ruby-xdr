require 'spec_helper'

class TestColor < XDR::Enum
  member :red, 0
  member :green, 1

  seal
end

describe XDR::Enum, ".read" do
  let(:zero) { "\x00\x00\x00\x00" }
  let(:one) { "\x00\x00\x00\x01" }
  let(:two) { "\x00\x00\x00\x02" }

  subject{ TestColor }

  it "decodes values correctly" do
    expect( read zero ).to eq(TestColor.red)
    expect( read one ).to eq(TestColor.green)
  end

  it "raises EnumValueError if the decoded value is not in the defined constants" do
    expect{ read two }.to raise_error XDR::EnumValueError
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end