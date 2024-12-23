module API
  module V1
    module Ingredients
      class Show < Base
        resources :ingredients do
          route_param :id do
            get do
              ingredient = ::Ingredient.find(params[:id])

              Serializers::V1::IngredientSerializer.new(ingredient: ingredient).to_h
            end
          end
        end
      end
    end
  end
end
