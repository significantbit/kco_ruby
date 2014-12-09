require 'bundler/setup'
Bundler.setup

require "codeclimate-test-reporter"

require 'webmock/rspec'
require 'kco_ruby'

WebMock.disable_net_connect!(:allow => "codeclimate.com")
WebMock.disable_net_connect!(allow: %w{codeclimate.com})

CodeClimate::TestReporter.start

RSpec.configure do |config|

end