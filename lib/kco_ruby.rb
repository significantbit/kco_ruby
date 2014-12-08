require "kco_ruby/user_agent"
require "kco_ruby/digester"
require "kco_ruby/order"
require "kco_ruby/request_context"
require "kco_ruby/response_handler"

require "kco_ruby/connector"

module KcoRuby
  def self.create_connector(secret)
    KcoRuby::Connector.new(UserAgent.new, KcoRuby.create_digester(secret))
  end
end

