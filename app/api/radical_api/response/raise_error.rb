require 'faraday'
require 'radical_api/error'

module RadicalApi
  # Faraday response middleware
  module Response

    # This class raises an Ohanakapa-flavored exception based on
    # HTTP status codes returned by the API
    class RaiseError < Faraday::Response::Middleware

      private

      def on_complete(response)
        if error = RadicalApi::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
