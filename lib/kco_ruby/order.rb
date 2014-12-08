module KcoRuby
  #This class represent an Order
  class Order
    include Enumerable

    class << self
      attr_accessor :content_type, :base_uri
    end

    def initialize(connector, uri=nil)
      @connector =connector
      self.location = uri
      @data = {}
    end

    #Set location
    def location=(value)
      @location = value.to_s if value
    end

    #Get location
    def location
      @location
    end

    #Get value for key
    def [](key)
      @data[key.to_s]
    end

    #Set a specific key to value
    def []=(key, value)
      @data[key.to_s]=value
    end

    #Keys returns all keys for order data
    def keys
      @data.keys
    end

    #Implementation of Enumerable, good for iteration over data
    def each
      @data.each {|key, value| yield key, value}
    end

    #Returns order content type
    def content_type
      Order.content_type
    end

    #Sets the order data
    def parse(data)
      @data = data
    end

    #Returns the order data
    def marshal
      @data
    end

    #Used when creating a new order
    def create(data)
      options = {
          "url" => Order.base_uri,
          "data" => data
      }

      @connector.apply(:post, self, options)
    end

    #When fetching a order that already exists
    def fetch
      options = {
          "url" => @location
      }

      @connector.apply(:get, self, options)
    end

    #Used when updating order information, ie. order status completed
    def update(data)
      options = {
          "url" => @location,
          "data" => data
      }

      @connector.apply(:post, self, options)
    end

  end
end
