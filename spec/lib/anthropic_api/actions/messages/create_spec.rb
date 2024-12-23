# frozen_string_literal: true

require 'spec_helper'
require "rails_helper"

describe AnthropicAPI::Actions::Messages::Create, integration: true do
  subject(:response) { described_class.new(client: client).call(payload) }

  let(:configuration) { AnthropicAPI::Configuration.new(api_token: token, model: model, timeout: timeout, context: context) }

  let(:token) { Settings.anthropic_api.api_key }
  let(:model) { Settings.anthropic_api.model }
  let(:timeout) { Settings.anthropic_api.timeout }

  let(:context) { 'you are a cat, you cannot speak human' }

  let(:client) { AnthropicAPI::Client.new(configuration: configuration) }

  let(:payload) do
    {
      "messages": [ { "role": "user", "content": "Hello there" } ]
    }
  end

  context 'with valid token' do
    context 'with valid params' do
      it 'responses with 200 status', :aggregate_failures do
        VCR.use_cassette('anthropic_api/messages/create/success') do
          expect(response.code).to eq(200)
        end
      end
    end

    context 'with invalid params' do
      let(:payload) { { data: 'invalid' } }

      it 'responses with 400 status', :aggregate_failures do
        VCR.use_cassette('anthropic_api/messages/create/failure/bad_request') do
          expect { response }.to raise_error(AnthropicAPI::Errors::BadRequestError)
        end
      end
    end
  end

  context 'with invalid token' do
    let(:token) { 'invalid' }
    it 'responses with 401 status', :aggregate_failures do
      VCR.use_cassette('anthropic_api/messages/create/failure/unauthorized') do
        expect { response }.to raise_error(AnthropicAPI::Errors::UnauthorizedError)
      end
    end
  end
end
