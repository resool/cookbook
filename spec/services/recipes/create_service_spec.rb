require "rails_helper"

describe Recipes::CreateService do
  subject(:call) { described_class.new(ingredients: ingredients).call }

  let(:ingredients) { [ create(:ingredient) ] }

  context 'with valid params' do
    it 'creates a recipe' do
      expect { call }.to change(Recipe, :count).by(1)
    end
  end
end
