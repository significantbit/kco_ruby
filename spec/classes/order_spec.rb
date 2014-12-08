require 'spec_helper'

describe KcoRuby::Order do
  context "with mock connector" do
    let(:connector) { instance_double(KcoRuby::Connector) }
    subject { KcoRuby::Order.new(connector) }

    describe "#new" do
      it "should set location if provided to constructor" do
        order = KcoRuby::Order.new(connector, 'http://test-uri')
        expect(order.location).to eq('http://test-uri')
      end
    end


    describe "#content_type=" do
      it 'should return class content type' do
        KcoRuby::Order.content_type = "application/json"
        expect(subject.content_type).to eq("application/json")
      end
    end

    describe "#location" do
      it 'should return empty location' do
        expect(subject.location).to be_nil
      end

      it 'should be able to set location' do
        url = "http://foo"
        subject.location = url
        expect(subject.location).to eq(url)
      end

      it 'should allways return string' do
        url = 5
        subject.location = url
        expect(subject.location).to be_instance_of(String)
      end

    end

    describe "#parse and #marshal" do
      it 'should parse and marshal identical' do
        data = {"foo" => "boo"}
        subject.parse(data)
        expect(subject.marshal).to eq(data)
      end
    end

    describe "#[](key)" do
      it 'should return data for key' do
        subject['key'] = "value"
        expect(subject['key']).to eq("value")
      end
    end

    describe "#[](key, value)=" do
      it 'should ignore if using string or symbols' do
        subject[:key] = "value"
        expect(subject['key']).to eq("value")
      end
    end

    describe "#keys" do
      it 'should return all keys' do
        subject["key1"] = "value1"
        subject["key2"] = "value2"
        expect(subject.keys).to contain_exactly("key1", "key2")
      end
    end

    describe "#create" do
      it 'should call connector#apply on #create' do
        location = "http://stub"
        subject.class.base_uri = location
        data ={"foo" => "boo"}

        expect(connector).to receive(:apply).with(:post, subject, {"url" => location, "data" => data})
        subject.create(data)
      end
    end

    describe "#fetch" do
      it 'should call connector#apply with GET, subject and option' do
        location = "http://stub"
        subject.location = location
        expect(connector).to receive(:apply).with(:get, subject, {"url" => location})
        subject.fetch
      end
    end

    describe "#update" do
      it 'should call connector#apply with POST, subject and options' do
        location = "http://klarna.com/foo/bar/13"
        subject.location = location
        data ={"foo" => "boo"}

        expect(connector).to receive(:apply).with(:post, subject, {"url" => location, "data" => data})
        subject.update(data)
      end
    end

    it 'should contain zero keys' do
      expect(subject.count).to eq(0)
    end

  end
end