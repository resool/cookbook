require "rails_helper"

describe Ingredients::CreateService do
  subject(:call) { described_class.new(input: input).call }

  let(:input) { 'citrus' }

  context 'with valid params' do
    it 'creates an ingredient' do
      expect { call }.to change(Ingredient, :count).by(1)
    end
  end

  context 'with invalid params' do
    context 'with empty input' do
      let(:input) { '' }

      it 'raise an error' do
        expect { call }.to raise_error(IngredientInputInvalidError)
      end
    end

    context 'when ingredient already exist' do
      before do
        create(:ingredient, input: input)
      end

      it 'raise an error' do
        expect { call }.to raise_error(IngredientNotUniqueError)
      end
    end
  end
end
