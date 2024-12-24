require 'swagger_helper'

describe 'API::V1::Ingredients::Index', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/ingredients' do
    get 'get an ingredient' do
      tags 'Ingredients'
      produces 'application/json'

      before do
        create(:ingredient)
        create(:ingredient)
      end

      response 200, :created do
        schema type: :array, items: {
          type: :object, properties: {
            id: { type: :integer },
            name: { type: :string, nullable: true },
            status: { type: :string },
            input: { type: :string }
          }
        }

        run_test! do
          expect(response.parsed_body.size).to eq(2)
        end
      end
    end
  end
end
