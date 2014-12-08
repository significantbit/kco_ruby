require 'spec_helper'

describe KcoRuby do
  describe "#call" do
    it "returns valid digest" do
      expected = "MO/6KvzsY2y+F+/SexH7Hyg16gFpsPDx5A2PtLZd0Zs="
      data = '{"eid":1245,"goods_list":[{"artno":"id_1","name":'\
            '"product","price":12345,"vat":25,"qty":1}],"currency":"SEK"'\
            ',"country":"SWE","language":"SV"}'
      digester = KcoRuby.create_digester("mySecret")
      expect(digester.call(data)).to eq(expected)
    end
  end
end