module Recipes
  class CreateService
    def initialize(ingredients:)
      @ingredients = ingredients
    end

    def call
      ActiveRecord::Base.transaction do
        create_recipe.tap do |recipe|
          recipe.ingredients << ingredients
        end
      end
      # TODO: call background job
    end

    private

    attr_reader :ingredients

    def create_recipe
      @create_recipe ||= Recipe.create!(status: "processing")
    end
  end
end
