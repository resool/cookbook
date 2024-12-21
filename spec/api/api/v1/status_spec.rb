require 'swagger_helper'

describe 'Check API v1 status' do
  path '/api/v1/status' do
    get 'v1 status' do
      tags 'Status'
      produces 'application/json'
      response '200', 'Status OK' do
        schema type: :object,
               properties: {
                 status: { type: :string, enums: %i[ok], example: 'ok' },
                 timestamp: { type: :string, description: 'iso 8601 timestamp format', example: '2024-12-21T15:30:12+00:00' }
               },
               required: [ 'status', 'timestamp' ]

        run_test!
      end
    end
  end
end
