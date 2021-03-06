require 'radical_api/response/raise_error'
require 'radical_api/version'

module RadicalApi

  # Default configuration options for {Client}
  module Default

    # Default API endpoint
    API_ENDPOINT = "http://ohana-api-demo.herokuapp.com/api".freeze

    # Default User Agent header string
    USER_AGENT   = "Ohanakapa Ruby Gem #{RadicalApi::VERSION}".freeze

    # Default media type
    MEDIA_TYPE   = "application/vnd.ohanapi-v1+json"

    # In Faraday 0.9, Faraday::Builder was renamed to Faraday::RackBuilder
    RACK_BUILDER_CLASS = defined?(Faraday::RackBuilder) ? Faraday::RackBuilder : Faraday::Builder

    # Default Faraday middleware stack
    MIDDLEWARE = RACK_BUILDER_CLASS.new do |builder|
      builder.use RadicalApi::Response::RaiseError
      builder.adapter Faraday.default_adapter
    end

    class << self

      # Configuration options
      # @return [Hash]
      def options
        Hash[RadicalApi::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # Default API endpoint from ENV or {API_ENDPOINT}
      # @return [String]
      def api_endpoint
        ENV['OHANA_API_ENDPOINT'] || API_ENDPOINT
      end

      # Default pagination preference from ENV
      # @return [String]
      def auto_paginate
        ENV['OHANAKAPA_AUTO_PAGINATE']
      end

      # Default pagination page size from ENV
      # @return [Fixnum] Page size
      def per_page
        page_size = ENV['OCTOKIT_PER_PAGE']

        page_size.to_i if page_size
      end

      # Default options for Faraday::Connection
      # @return [Hash]
      def connection_options
        {
          :headers => {
            :accept => default_media_type,
            :user_agent => user_agent
          }
        }
      end

      # Default media type from ENV or {MEDIA_TYPE}
      # @return [String]
      def default_media_type
        ENV['OHANAKAPA_DEFAULT_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # Default middleware stack for Faraday::Connection
      # from {MIDDLEWARE}
      # @return [String]
      def middleware
        MIDDLEWARE
      end

      # Default proxy server URI for Faraday connection from ENV
      # @return [String]
      def proxy
        ENV['OHANAKAPA_PROXY']
      end

      # Default api token for Ohana API
      # @return [String]
      def api_token
        ENV['OHANAKAPA_API_TOKEN']
      end

      # Default User-Agent header string from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV['OHANAKAPA_USER_AGENT'] || USER_AGENT
      end

    end
  end
end
