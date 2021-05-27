require "spec_helper"

describe XDR::Option, ".read" do
  subject { XDR::Option[XDR::Int] }

  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x01\x00\x00\x00\x00")).to eq(0)
    expect(read("\x00\x00\x00\x00")).to eq(nil)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end

describe XDR::Option, ".write" do
  subject { XDR::Option[XDR::Int] }

  it "decodes values correctly" do
    expect(write(0)).to eq_bytes("\x00\x00\x00\x01\x00\x00\x00\x00")
    expect(write(nil)).to eq_bytes("\x00\x00\x00\x00")
  end

  context "when the provided value is not nil, but invalid for the child type" do
    it "raises WriteError " do
      expect { write(1.0) }.to raise_error(XDR::WriteError)
      expect { write("hi") }.to raise_error(XDR::WriteError)
    end
  end

  context "when provided value is empty string" do
    subject { XDR::Option[XDR::VarOpaque[64]] }

    it "writes empty string" do
      expect(write("")).to eq_bytes("\x00\x00\x00\x01\x00\x00\x00\x00")
    end
  end

  def write(val)
    io = StringIO.new
    subject.write(val, io)
    io.string
  end
end
