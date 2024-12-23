require 'swagger_helper'

describe 'API::V1::Recipes::Show', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/recipes/{id}' do
    get 'get a recipe' do
      tags 'Recipes'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer

      response 200, :created do
        let(:id) { create(:recipe).id }

        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string, nullable: true },
          status: { type: :string }
        }

        run_test!
      end

      response 404, 'Recipe not found' do
        let(:id) { 0 }

        schema type: :object, properties: {
          error: { type: :string }
        }

        run_test!
      end
    end
  end
end
