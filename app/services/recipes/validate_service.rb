module Recipes
  class ValidateService
    CONTEXT = '
      you are a very primitive robot that can do only "bee" for yes or "beebee" for no.
      you are not allowed to output more info.
      keep in mind that the input is from middle ages.
    '
    YES = "bee"
    NO = "beebee"

    def initialize(recipe:)
      @recipe = recipe
    end

    def call
      if response == YES
        recipe.update!(status: "valid")
      elsif response == NO
        recipe.update!(status: "failure")
      end
    end

    private

    attr_reader :recipe

    def response
      @response ||= AnthropicAPI::Actions::Messages::Create.new(client: client).call(payload).parsed_body.dig("content", 0, "text")
    end

    def client
      AnthropicAPI::Client.new(configuration: configuration)
    end

    def configuration
      @configuration ||= AnthropicAPI::Configuration.new(
        api_token: Settings.anthropic_api.api_key,
        model: Settings.anthropic_api.model,
        timeout: Settings.anthropic_api.timeout,
        context: CONTEXT)
    end

    def payload
      {
        "messages": [
          { "role": "user", "content": "is this valid food recipe containing those * divided ingredients?" },
          { "role": "user", "content": recipe.ingredients.pluck(:input).join("*") },
          { "role": "user", "content": recipe.content }
        ]
      }
    end
  end
end
