require 'rails_helper'

RSpec.describe RecipeJob, type: :job do
  subject(:perform) { described_class.new.perform(recipe.id) }

  let(:recipe) { create(:recipe) }

  before do
    allow_any_instance_of(Recipes::GenerateService).to receive(:call)
  end

  it 'calls the Recipes::GenerateService with the correct recipe' do
    expect(Recipes::GenerateService).to receive(:new).with(recipe: recipe).and_call_original

    perform
  end
end
