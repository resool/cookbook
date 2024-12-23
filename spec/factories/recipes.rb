FactoryBot.define do
  factory :recipe do
    content { Faker::Food.description }

    ingredients do
      build_list(:ingredient, 3)
    end
  end
end
