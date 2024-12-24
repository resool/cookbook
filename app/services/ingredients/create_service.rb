module Ingredients
  class CreateService
    def initialize(input:)
      @input = input
    end

    def call
      validate_input

      create_ingredient
    end

    private

    attr_reader :input

    def validate_input
      return if input.present?

      raise IngredientInputInvalidError
    end

    def create_ingredient
      Ingredient.create!(input: input, status: "processing")
    rescue ActiveRecord::RecordNotUnique
      raise IngredientNotUniqueError
    end
  end
end
