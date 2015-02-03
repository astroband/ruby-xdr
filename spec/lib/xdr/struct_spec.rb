require 'spec_helper'

module StructSpec
  class SampleError < XDR::Struct
    attribute :code, XDR::Int
    attribute :msg,  XDR::String[100]
  end


  # class SampleEnvelope < XDR::Struct
  #   attribute :body,  XDR::VarOpaque[]
  #   attribute :sigs,  XDR::VarArray[XDR::Opaque[32]]
  # end

  # class SampleOptions < XDR::Struct
  #   attribute :limit,       XDR::Option[XDR::Int]
  #   attribute :subscribed,  XDR::Option[XDR::Bool]
  # end
end


describe XDR::Struct, "creation" do
  let(:args){ {} }
  subject{ StructSpec::SampleError.new(args) }

  context "with no args" do
    it "creates an instance" do
      expect(subject).to be_a(StructSpec::SampleError)
    end
  end

  context "with valid args" do
    let(:args){{code: 3, msg: "It broke!"}}

    it "assigns values correctly" do
      expect(subject.code).to eq(3)
      expect(subject.msg).to eq("It broke!")
    end
  end
end

describe XDR::Struct, "attribute assignment" do
  subject{ StructSpec::SampleError.new }

  it "roundtrips correctly" do
    expect(subject.code).to be_nil
    expect(subject.msg).to be_nil

    subject.code = 10
    subject.msg = "busted"

    expect(subject.code).to eq(10)
    expect(subject.msg).to eq("busted")
  end
end


describe XDR::Struct, "valid?"
describe XDR::Struct, "optional members"

describe XDR::Struct, ".to_xdr" do
  subject{ StructSpec::SampleError.new({code: 3, msg: "It broke!"}) }
  let(:result){ subject.to_xdr }

  it "serialized each field in order" do
    expect(result[0...4]).to eq("\x00\x00\x00\x02")
    expect(result[4...8]).to eq("\x00\x00\x00\x03")
    expect(result[8...12]).to eq([9].pack("l>"))
    expect(result[12..-1]).to eq("It broke!\x00\x00\x00")
  end

  it "raises an exception if the struct is not valid"
end