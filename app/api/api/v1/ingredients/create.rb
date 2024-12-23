module API
  module V1
    # V1 API Status endpoint - just to check everything is properly configured
    module Ingredients
      class Create < Base
        params do
          requires :input, type: String, allow_blank: false
        end

        resources :ingredients do
          post do
            ingredient = ::Ingredients::CreateService.new(input: params[:input]).call

            Serializers::V1::IngredientSerializer.new(ingredient: ingredient).to_h
          end
        end
      end
    end
  end
end
