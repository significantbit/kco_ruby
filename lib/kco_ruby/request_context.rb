module KcoRuby
  #RequestContext is responsible for building the correct request
  class RequestContext

    def initialize(uri, resource, connector)
      @uri = uri
      @resource = resource
      @connector = connector
    end

    def parse(method, options)
      case method
        when :get
          create_get_request
        when :post
          create_post_request(options['data'] || @resource.marshal)
        else
          raise Exception.new("#{method} is not a valid HTTP method")
      end
    end


    def perform_request
      Net::HTTP.start(@uri.hostname,
                      @uri.port,
                      :use_ssl => @uri.scheme == 'https') do |http|
        http.request(@request)
      end
    end

    private
    def create_get_request
      @request = Net::HTTP::Get.new(@uri)
      add_headers
    end

    def create_post_request(data)
      @request = Net::HTTP::Post.new(@uri)
      add_payload(data)
      add_payload_headers
    end


    def add_payload(data)
      @request.body = data.to_json
    end

    def add_payload_headers
      @request['User-agent'] = @connector.user_agent.to_s
      @request['Content-Type'] = @resource.content_type.to_s
      set_authorization(@request.body)
      @request['Accept'] = @request['Content-Type']
    end

    def add_headers
      @request['User-agent'] = @connector.user_agent.to_s
      set_authorization()
      @request['Accept'] = @resource.content_type
    end

    def set_authorization(data='')
      @request['Authorization'] = "Klarna #{@connector.digester.call(data)}"
    end
  end
end
