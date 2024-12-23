require 'swagger_helper'

describe 'Ingredients API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/ingredients' do
    post 'create an ingredient' do
      tags 'Ingredients'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :ingredient_params, in: :body, schema: {
        type: :object,
        properties: {
          input: { type: :string }
        },
        required: %i[input]
      }

      response 201, :created do
        let(:ingredient_params) { { input: 'Citrus' } }

        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string, nullable: true },
          status: { type: :string },
          input: { type: :string }
        }

        run_test!
      end

      response 400, :bad_request do
        let(:ingredient_params) { { input: '' } }

        schema type: :object, properties: {
          error: { type: :string }
        }

        run_test!
      end
    end
  end
end
