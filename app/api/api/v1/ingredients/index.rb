module API
  module V1
    module Ingredients
      class Index < Base
        resources :ingredients do
          get do
            ::Ingredient.find_each.map do |ingredient|
              Serializers::V1::IngredientSerializer.new(ingredient: ingredient).to_h
            end
          end
        end
      end
    end
  end
end
