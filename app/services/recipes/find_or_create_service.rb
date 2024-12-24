module Recipes
  class FindOrCreateService
    def initialize(ingredients:)
      @ingredients = ingredients
    end

    def call
      find_recipe || create_recipe
    end

    private

    attr_reader :ingredients

    def find_recipe
      @recipe = Recipe.joins(:ingredients)
        .where(ingredients: { id: ingredient_ids })
        .group("recipes.id")
        .having("COUNT(ingredients.id) = ?", ingredient_ids.size)
        .having("COUNT(ingredients.id) = (SELECT COUNT(*) FROM ingredient_recipes WHERE ingredient_recipes.recipe_id = recipes.id)")
        .first
    end

    def ingredient_ids
      @ingredient_ids ||= ingredients.pluck(:id)
    end

    def create_recipe
      new_recipe.tap do |recipe|
        recipe.ingredients << ingredients
        RecipeJob.perform_async(recipe.id)
      end
    end

    def new_recipe
      @create_recipe ||= Recipe.create!(status: "processing")
    end
  end
end
