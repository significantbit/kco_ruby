require 'spec_helper'

describe KcoRuby::Connector do
  let(:user_agent) { instance_double KcoRuby::UserAgent }
  let(:digester) { double KcoRuby.create_digester('secret') }
  let(:resource) { double KcoRuby::Order }
  subject { KcoRuby::Connector.new(user_agent, digester) }

  describe "#apply" do
    it "should set correct headers on GET" do
      expect(digester).to receive(:call).with('').and_return('digest')
      expect(resource).to receive(:content_type).and_return("application/json")
      expect(user_agent).to receive(:to_s).and_return("user-agent")
      expect(resource).to receive(:parse).with({"item" => "foo"})

      stub_request(:get, "http://test/").
          with(:headers => {'User-Agent' => 'user-agent',
                            'Authorization' => 'Klarna digest'}).
          to_return(:status => 200, :body => '{"item": "foo"}', :headers => {})

      subject.apply(:get, resource, {'url' => 'http://test'})
    end

    it "should send data instead of marshal of order when data option is set" do
      expect(resource).to receive(:content_type).and_return("application/json")
      expect(user_agent).to receive(:to_s).and_return("user-agent")
      expect(digester).to receive(:call).with('{"foo":"bar"}').and_return('digest')
      expect(resource).to receive(:location=).with("http://test/")

      stub_request(:post, "http://test/").
          with(:body => "{\"foo\":\"bar\"}",
               :headers => {'User-Agent' => 'user-agent',
                            'Authorization' => 'Klarna digest'}).
          to_return(:status => 201, :headers => {location:'http://test/'})

      subject.apply(:post, resource, {'url' => 'http://test', 'data' => {foo: 'bar'}})
    end

    it "should use digester for POST request" do
      expect(resource).to receive(:marshal).and_return({"foo" => 'bar'})
      expect(resource).to receive(:location).and_return("http://test")
      expect(resource).to receive(:content_type).and_return("application/json")

      expect(digester).to receive(:call).with('{"foo":"bar"}').and_return('test-digest')
      expect(user_agent).to receive(:to_s).and_return("user-agent")
      expect(resource).to receive(:parse).with({"foo" => "bar"})

      stub_request(:post, "http://test/").
          with(:headers => {
                   'User-Agent' => 'user-agent',
                   'Authorization' => 'Klarna test-digest'}).
          to_return(:status => 200, :body => '{"foo": "bar"}', :headers => {})

      subject.apply(:post, resource)
    end

    it "should update location on 201 " do
      expect(resource).to receive(:marshal).and_return({"foo" => 'bar'})
      expect(resource).to receive(:location).and_return("http://test")
      expect(resource).to receive('location=').with('http://updated')
      expect(resource).to receive(:content_type).and_return("application/json")

      expect(digester).to receive(:call).with('{"foo":"bar"}').and_return('test-digest')
      expect(user_agent).to receive(:to_s).and_return("user-agent")
      stub_request(:post, "http://test/").
          with(:headers => {
                   'User-Agent' => 'user-agent',
                   'Authorization' => 'Klarna test-digest'}).
          to_return(:status => 201, :body => '{"foo": "bar"}', :headers => {location: 'http://updated'})

      subject.apply(:post, resource)
    end

    it "should raise exception on wrong status code " do
      expect(resource).to receive(:location).and_return("http://test")
      expect(resource).to receive(:content_type).and_return("application/json")

      expect(digester).to receive(:call).with('').and_return('test-digest')
      expect(user_agent).to receive(:to_s).and_return("user-agent")
      stub_request(:get, "http://test/").
          with(:headers => {
                   'User-Agent' => 'user-agent',
                   'Authorization' => 'Klarna test-digest'}).
          to_return(:status => 404, :body => 'not found', :headers => {})

      expect { subject.apply(:get, resource) }.to raise_error
    end

    it "should raise exception on wrong method type" do
      expect(resource).to receive(:location).and_return("http://test")
      expect { subject.apply(:patch, resource) }.to raise_error
    end

  end

end