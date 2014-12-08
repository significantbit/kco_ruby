module KcoRuby

  #When a Response is created this class describe all actions that needs to happen with that response
  class ResponseHandler
    def initialize(response, resource)
      @resource = resource
      @response = response
    end

    def handle_response
      case @response
        when Net::HTTPOK
          update_resource_data
        when Net::HTTPCreated
          update_resource_location
        else
          raise Exception.new("Invalid response #{@response.inspect}")
      end
    end

    def location
      @response['location']
    end

    def data
      @response.body.strip
    end

    private

    def update_resource_location
      @resource.location = location if location
    end

    def update_resource_data
      @resource.parse JSON.parse(data) if data != ""
    end

  end
end