require 'bundler/setup'
Bundler.setup

require "codeclimate-test-reporter"

require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => "codeclimate.com")
WebMock.disable_net_connect!(allow: %w{codeclimate.com})
CodeClimate::TestReporter.start

require 'kco_ruby'


RSpec.configure do |config|

end