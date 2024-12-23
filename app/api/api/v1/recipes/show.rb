module API
  module V1
    module Recipes
      class Show < Base
        resources :recipes do
          route_param :id do
            get do
              recipe = ::Recipe.find(params[:id])

              Serializers::V1::RecipeSerializer.new(recipe: recipe).to_h
            end
          end
        end
      end
    end
  end
end
