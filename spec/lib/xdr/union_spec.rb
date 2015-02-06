require 'spec_helper'

module UnionSpec
  module ResultType
    include XDR::Enum
    OK       = 0
    ERROR    = 1
    NONSENSE = 2
  end

  class Result < XDR::Union
    switch_on ResultType, :type

    switch ResultType::OK
    switch ResultType::ERROR, :message
    switch :default

    attribute :message, XDR::String[]
  end
end

describe XDR::Union, ".read" do
  
  subject{ UnionSpec::Result }
  let(:result){ subject.read(bytes) }

  context "with a void arm encoded" do
    let(:bytes){ StringIO.new "\x00\x00\x00\x00" }

    it "decodes correctly" do
      expect(result).to be_a(UnionSpec::Result)
      expect(result.switch).to eq(UnionSpec::ResultType::OK)
      expect(result.arm).to be_nil
      expect(result.get).to be_nil
    end
  end

  context "with a non-void arm encoded" do
    let(:bytes){ StringIO.new "\x00\x00\x00\x01\x00\x00\x00\x0812345678" }

    it "decodes correctly" do
      expect(result).to be_a(UnionSpec::Result)
      expect(result.switch).to eq(UnionSpec::ResultType::ERROR)
      expect(result.arm).to eq(:message)
      expect(result.get).to eq("12345678")
      expect(result.message!).to eq("12345678")
    end
  end

  context "with a default arm encoded" do
    let(:bytes){ StringIO.new "\x00\x00\x00\x02" }

    it "decodes correctly" do
      expect(result).to be_a(UnionSpec::Result)
      expect(result.switch).to eq(UnionSpec::ResultType::NONSENSE)
      expect(result.arm).to be_nil
      expect(result.get).to be_nil
    end
  end

end