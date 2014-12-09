require 'bundler/setup'
Bundler.setup

require 'simplecov'
require "codeclimate-test-reporter"
SimpleCov.add_filter 'vendor'
SimpleCov.formatters = []

require 'webmock/rspec'
require 'kco_ruby'

WebMock.disable_net_connect!(:allow => "codeclimate.com")
WebMock.disable_net_connect!(allow: %w{codeclimate.com})


SimpleCov.start CodeClimate::TestReporter.configuration.profile

RSpec.configure do |config|

end