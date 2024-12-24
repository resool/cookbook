module API
  module V1
    # V1 API Status endpoint - just to check everything is properly configured
    module Recipes
      class Create < Base
        params do
          requires :ingredient_ids, type: Array[Integer], allow_blank: false
        end

        resources :recipes do
          post do
            ingredients = Ingredient.find(params[:ingredient_ids])
            recipe = ::Recipes::FindOrCreateService.new(ingredients: ingredients).call
            Serializers::V1::RecipeSerializer.new(recipe: recipe).to_h
          end
        end
      end
    end
  end
end
