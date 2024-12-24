require "rails_helper"

describe Recipes::GenerateService do
  subject(:call) { described_class.new(recipe: recipe).call }

  let(:recipe) { create(:recipe, ingredients: [ build(:ingredient, input: 'tomato'), build(:ingredient, input: 'potato') ]) }
  let(:validate_instance) { instance_double(Recipes::ValidateService, call: nil) }

  before do
    allow(Recipes::ValidateService).to receive(:new).with(recipe: recipe).and_return(validate_instance)
  end

  it 'saves recipe instructions' do
    VCR.use_cassette('services/generate') do
      expect { call }.to change { recipe.reload.content }
    end
  end

  it 'calls validator service' do
    expect(validate_instance).to receive(:call)

    VCR.use_cassette('services/generate') { call }
  end

  it 'calls validator service' do
    expect(validate_instance).to receive(:call)

    VCR.use_cassette('services/generate') { call }
  end

  it 'updates status' do
    VCR.use_cassette('services/generate') do
      expect { call }.to change { recipe.reload.status }.to('validating')
    end
  end
end
