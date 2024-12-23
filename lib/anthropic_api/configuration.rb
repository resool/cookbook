
module AnthropicAPI
  class Configuration
    attr_reader :api_token, :model, :timeout, :context

    def initialize(api_token:, model:, timeout:, context:)
      @api_token = api_token
      @timeout = timeout
      @model = model
      @context = context
    end
  end
end
