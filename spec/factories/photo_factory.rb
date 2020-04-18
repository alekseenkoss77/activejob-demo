FactoryBot.define do
  factory :photo do
    title { Faker::Movies::StarWars.wookiee_sentence }
    author { Faker::Movies::StarWars.character }

    after(:create) do |photo, evaluator|
      photo.file.attach(
        io: File.open(Rails.root.join("spec", "fixtures", 'test.jpg')),
        filename: 'test.jpg'
      )
    end
  end
end
