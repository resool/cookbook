require "rails_helper"

describe Recipes::ValidateService do
  subject(:call) { described_class.new(recipe: recipe).call }

  let(:recipe) { create(:recipe, content: content, ingredients: ingredients, status: 'validating') }
  let(:ingredients) { [ build(:ingredient, input: 'tomato'), build(:ingredient, input: 'potato') ] }

  context 'with valid recipe' do
    let(:content) do
      'potato salad. 1.buy tomato and potato. 2. slice tomato. 3. bake potato. 4. mix potato with tomato'
    end

    it 'sets recipe to valid' do
      VCR.use_cassette('services/validate/success') do
        expect { call }.to change { recipe.reload.status }.to('valid')
      end
    end
  end

  context 'with invalid recipe' do
    let(:content) { 'mix bleach and ammonia' } # never do that

    it 'sets recipe to invalid' do
      VCR.use_cassette('services/validate/poison') do
        expect { call }.to change { recipe.reload.status }.to('failure')
      end
    end

    context 'with extra ingredient' do
      let(:ingredients) do
        [
          build(:ingredient, input: 'tomato'),
          build(:ingredient, input: 'potato'),
          build(:ingredient, input: 'citrus')
        ]
      end

      it 'sets recipe to invalid' do
        VCR.use_cassette('services/validate/incomplete') do
          expect { call }.to change { recipe.reload.status }.to('failure')
        end
      end
    end
  end
end
