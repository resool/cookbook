require 'swagger_helper'

describe 'API::V1::Recipes::Create', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/recipes' do
    post 'create an ingredient' do
      tags 'Recipes'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :recipe_params, in: :body, schema: {
        type: :object,
        properties: {
          ingredient_ids: { type: :array }
        },
        required: %i[ingredient_ids]
      }

      response 201, :created do
        let(:ingredient) { create(:ingredient) }
        let(:another_ingredient) { create(:ingredient) }

        let(:recipe_params) { { ingredient_ids: [ ingredient.id, another_ingredient.id ] } }

        schema type: :object, properties: {
          id: { type: :integer },
          content: { type: :string, nullable: true },
          status: { type: :string }
        }

        run_test!
      end

      response 400, :bad_request do
        let(:recipe_params) { { ingredient_ids: [] } }

        schema type: :object, properties: {
          error: { type: :string }
        }

        run_test!
      end

      response 404, :recipe_not_found do
        let(:recipe_params) { { ingredient_ids: [ 0 ] } }

        schema type: :object, properties: {
          error: { type: :string }
        }

        run_test!
      end
    end
  end
end
