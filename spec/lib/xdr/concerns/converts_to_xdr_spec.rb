require 'spec_helper'

describe XDR::Concerns::ConvertsToXDR do
  subject{ UnimplementedConvertible.new }

  it "requires an implementation of #read" do
    expect{ subject.read(StringIO.new) }.to raise_error(NotImplementedError)
  end

  it "requires an implementation of #write" do
    expect{ subject.write(3, StringIO.new) }.to raise_error(NotImplementedError)
  end

  it "requires an implementation of #valid?" do
    expect{ subject.valid?(3) }.to raise_error(NotImplementedError)
  end
end

describe XDR::Concerns::ConvertsToXDR, "#to_xdr" do
  subject{ ImplementedConvertible.new }

  it "calls through to write" do
    expect(subject).to receive(:write).with("hiya", kind_of(StringIO))
    subject.to_xdr("hiya")
  end
end

describe XDR::Concerns::ConvertsToXDR, "#from_xdr" do
  subject{ ImplementedConvertible.new }

  it "calls through to write" do
    expect(subject).to receive(:read).with(kind_of(StringIO))
    subject.from_xdr("hiya")
  end
end

class UnimplementedConvertible
  include XDR::Concerns::ConvertsToXDR
end

class ImplementedConvertible
  include XDR::Concerns::ConvertsToXDR

  def read(io)
    read_bytes(4)
  end

  def write(val, io)
    io.write(val)
  end

  def valid?(val)
    true
  end
end