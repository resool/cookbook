require "rails_helper"

describe Recipes::FindOrCreateService do
  subject(:call) { described_class.new(ingredients: ingredients).call }

  let(:ingredients) { [ create(:ingredient) ] }

  context 'when recipe does not exist' do
    it 'creates a recipe' do
      expect { call }.to change(Recipe, :count).by(1)
    end

    it 'queues a recipe job' do
      expect { call }.to change { RecipeJob.jobs.size }.from(0).to(1)
    end
  end

  context 'when recipe exists' do
    let!(:recipe) { create(:recipe, ingredients: ingredients) }

    it 'returns a recipe' do
      expect(call).to eq(recipe)
    end

    it 'does not create a new recipe' do
      expect { call }.to_not change(Recipe, :count)
    end
  end

  context 'when recipe exists with additional ingredients' do
    before do
      create(:recipe, ingredients: [ *ingredients, create(:ingredient) ])
    end

    it 'creates a recipe' do
      expect { call }.to change(Recipe, :count).by(1)
    end
  end
end
