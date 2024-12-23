require 'swagger_helper'

describe 'API::V1::Ingredients::Create', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/ingredients/{id}' do
    get 'get an ingredient' do
      tags 'Ingredients'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer

      response 200, :created do
        let(:id) { create(:ingredient).id }

        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string, nullable: true },
          status: { type: :string },
          input: { type: :string }
        }

        run_test!
      end

      response 404, 'Ingredient not found' do
        let(:id) { 0 }

        schema type: :object, properties: {
          error: { type: :string }
        }

        run_test!
      end
    end
  end
end
