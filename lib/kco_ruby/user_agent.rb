require "kco_ruby/version"
require 'sys/uname'

module KcoRuby

  #Responsible for creating User agent strings
  class UserAgent
    include Sys

    def initialize
      # Components of the user-agent
      @fields = []
      add_field(UserAgentField.new('Library', "Significantbit.KCO.ApiWrapper", KcoRuby::VERSION))
      add_field(UserAgentField.new('OS', Uname.sysname, RUBY_PLATFORM))
      add_field(UserAgentField.new('Language', "Ruby", RUBY_VERSION))
    end

    def add_field(field)
      @fields << field
    end

    def to_s
      @fields.map { |field| field.to_s }.join(" ")
    end
  end

  #The field class is used to describe a UserAgent field
  class UserAgentField
    attr_accessor :identifier, :name, :version
    attr_writer :options

    def initialize(identifier, name, version, options = nil)
      @identifier = identifier
      @name = name
      @version = version
      @options = options
    end

    def to_s
      ["#{@identifier}/#{@name}_#{@version}", options_as_string].join(" ").strip
    end

    def options_as_string
      "(#{@options.join(" ; ")})" if @options
    end
  end

end
