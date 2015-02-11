require 'spec_helper'

module UnionSpec
  class ResultType < XDR::Enum
    member :ok, 0
    member :error, 1
    member :nonsense, 2

    seal
  end

  class Result < XDR::Union
    switch_on ResultType, :type

    switch ResultType.ok
    switch ResultType.error, :message
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
      expect(result.switch).to eq(UnionSpec::ResultType.ok)
      expect(result.arm).to be_nil
      expect(result.get).to be_nil
    end
  end

  context "with a non-void arm encoded" do
    let(:bytes){ StringIO.new "\x00\x00\x00\x01\x00\x00\x00\x0812345678" }

    it "decodes correctly" do
      expect(result).to be_a(UnionSpec::Result)
      expect(result.switch).to eq(UnionSpec::ResultType.error)
      expect(result.arm).to eq(:message)
      expect(result.get).to eq("12345678")
      expect(result.message!).to eq("12345678")
    end
  end

  context "with a default arm encoded" do
    let(:bytes){ StringIO.new "\x00\x00\x00\x02" }

    it "decodes correctly" do
      expect(result).to be_a(UnionSpec::Result)
      expect(result.switch).to eq(UnionSpec::ResultType.nonsense)
      expect(result.arm).to be_nil
      expect(result.get).to be_nil
    end
  end

end