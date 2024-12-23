module AnthropicAPI
  class Client
    include HTTParty
    VERSION = "2023-06-01"

    def initialize(configuration:)
      @configuration = configuration
    end

    def post(path, payload)
      response = self.class.post(
        "#{Settings.anthropic_api.base_url}#{path}",
        {
          body: default_payload.deep_merge(payload).to_json,
          headers: headers,
          timeout: timeout
        }
      )
      Response.new(response: response).call
    end

    private

    attr_reader :configuration
    delegate :base_url, :api_token, :timeout, :model, :context, to: :configuration

    def default_payload
      {
        model: model,
        system: context,
        max_tokens: 1024
      }.compact
    end

    def headers
      {
        'x-api-key': api_token,
        'anthropic-version': VERSION,
        'content-type': "application/json"
      }
    end
  end
end
