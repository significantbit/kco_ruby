require 'spec_helper'

describe KcoRuby::UserAgentField do
  describe "#to_s" do
    context "With options" do
      subject { KcoRuby::UserAgentField.new('Test', 'name', 'version', [1, 2]) }
      it "it serializes correctly" do
        expected = "Test/name_version (1 ; 2)"
        expect(subject.to_s).to eq(expected)
      end
    end

    context "Without options" do
      subject { KcoRuby::UserAgentField.new('Test', 'name', 'version') }
      it "it serializes correctly without options" do
        expected = "Test/name_version"
        expect(subject.to_s).to eq(expected)
      end
    end
  end

end