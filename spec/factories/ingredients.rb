FactoryBot.define do
  factory :ingredient do
    input { Faker::Quote.unique.famous_last_words }
    name { Faker::Food.unique.ingredient }
    status { "valid" }

    trait :valid do
      status { "valid" }
    end

    trait :problematic do
      input { "the black liquir you put in the engine" }
      status { "problematic" }
      name { nil }
    end

    trait :processing do
      input { "something sour and yellow" }
      name { nil }
      status { "processing" }
    end
  end
end
