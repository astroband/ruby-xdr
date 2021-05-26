require "spec_helper"

describe XDR::Float, ".read" do
  it "decodes values correctly" do
    expect(read("\x00\x00\x00\x00")).to eq(0.0)
    expect(read("\x80\x00\x00\x00")).to eq(-0.0)
    expect(read("\x3F\x80\x00\x00")).to eq(1.0)
    expect(read("\xBF\x80\x00\x00")).to eq(-1.0)
  end

  def read(str)
    io = StringIO.new(str)
    subject.read(io)
  end
end

describe XDR::Float, ".write" do
  it "encodes values correctly" do
    expect(write(0.0)).to eq_bytes("\x00\x00\x00\x00")
    expect(write(-0.0)).to eq_bytes("\x80\x00\x00\x00")
    expect(write(1.0)).to eq_bytes("\x3F\x80\x00\x00")
    expect(write(-1.0)).to eq_bytes("\xBF\x80\x00\x00")
  end

  it "raises a WriteError when the value is not Float" do
    expect { write 3 }.to raise_error(XDR::WriteError)
    expect { write "hello" }.to raise_error(XDR::WriteError)
    expect { write "1.0" }.to raise_error(XDR::WriteError)
  end

  def write(val)
    io = StringIO.new
    subject.write(val, io)
    io.string
  end
end
