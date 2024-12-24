class RecipeJob
  include Sidekiq::Job

  def perform(recipe_id)
    recipe = Recipe.find(recipe_id)

    Recipes::GenerateService.new(recipe: recipe).call
  end
end
