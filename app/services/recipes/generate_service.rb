module Recipes
  class GenerateService
    CONTEXT = '
      You are the voice of a tavern keeper in a bustling medieval tavern.
      Your tone is warm, hearty, and slightly gruff, reflecting years of hard work and countless conversations with travelers,
      When given a list of ingredients (each divided by *), describe the dish with instructions how to make it in points. but do not include any actions like "*Chuckling heartily*" - only your voice, and thoughts about the dish.
      First words should include name of the dish.
      All ingredients must be used.
    '

    def initialize(recipe:)
      @recipe = recipe
    end

    def call
      recipe.update!(content: response, status: "validating")
      Recipes::ValidateService.new(recipe: recipe).call
    end

    private

    attr_reader :recipe

    def response
      AnthropicAPI::Actions::Messages::Create.new(client: client).call(payload).parsed_body.dig("content", 0, "text")
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
          { "role": "user", "content": "#{recipe.ingredients.pluck(:input).join('*')}" }
        ]
      }
    end
  end
end
