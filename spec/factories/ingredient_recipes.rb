FactoryBot.define do
  factory :ingredient_recipe do
    association :ingredient
    association :recipe
  end
end
