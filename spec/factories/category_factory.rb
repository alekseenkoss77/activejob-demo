FactoryBot.define do
  factory :category do
    sequence :title do |n|
      "Category title #{n}"
    end
  end
end
