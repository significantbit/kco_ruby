require 'spec_helper'

describe KcoRuby::UserAgent do

  describe "#to_s" do
    it 'should contain OS version' do
      expect(subject.to_s).to match(/OS\/[^\ ]+_[^\ ]+/)
    end

    it 'should contain Library version' do
      expect(subject.to_s).to match(/Library\/[^\ ]+_[^\ ]+/)
    end

    it 'should contain OS version' do
      expect(subject.to_s).to match(/Language\/[^\ ]+_[^\ ]+/)
    end
  end

  describe "#add_field" do
    it 'should add field to fields' do
      field = KcoRuby::UserAgentField.new("Module",
                                          "Magento",
                                          "5.0", ["LanguagePack/7", "JsLib/2.0"])
      subject.add_field(field)
      expect(subject.to_s).to match(/Module\/Magento_5\.0 \(LanguagePack\/7 ; JsLib\/2\.0\)/)
    end
  end
end