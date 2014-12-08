require 'json/ext'
require 'net/http'

module KcoRuby

  #Responsible for connections against API
  class Connector
    attr_reader :user_agent, :digester

    def initialize(user_agent, digester)
      @user_agent = user_agent
      @digester =digester
    end

    #Apply will carryout the order with the collaborators
    def apply(method, resource, options={})
      uri = URI(options['url'] || resource.location)
      request_context = RequestContext.new(uri, resource, self)
      request_context.parse(method, options)
      ResponseHandler.new(request_context.perform_request, resource).handle_response
    end
  end
end
