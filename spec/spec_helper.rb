require 'bundler/setup'
Bundler.setup

require 'simplecov'
require "codeclimate-test-reporter"
SimpleCov.add_filter 'vendor'
SimpleCov.formatters = []
SimpleCov.start CodeClimate::TestReporter.configuration.profile

require 'webmock/rspec'
require 'kco_ruby'
WebMock.disable_net_connect!(:allow => "codeclimate.com")
WebMock.disable_net_connect!(allow: %w{codeclimate.com})

RSpec.configure do |config|

end