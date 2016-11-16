cache_store = ActiveSupport::Cache.lookup_store(:dalli_store)

stack = Faraday::RackBuilder.new do |builder|
  builder.use Faraday::HttpCache, store: cache_store, serializer: Marshal
  builder.use RadicalApi::Response::RaiseError
  builder.adapter Faraday.default_adapter
end

RadicalApi.configure do |config|
  config.api_token = ENV['OHANA_API_TOKEN'] if ENV['OHANA_API_TOKEN'].present?
  config.api_endpoint = ENV['OHANA_API_ENDPOINT']

  config.middleware = stack
end
