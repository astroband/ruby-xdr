require 'spec_helper'


describe XDR::DSL::Union, "#switch" do

  it "allows symbols in switch declarations" do
    expect do
      klass = Class.new(XDR::Union) do
        switch_on ResultType, :type
        switch :ok
      end

      klass.new(:ok)
    end.to_not raise_error
  end

  class ResultType < XDR::Enum
    member :ok, 0
    member :error, 1
    seal
  end
end