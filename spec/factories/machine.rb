FactoryBot.define do
  factory :machine do
    name { Faker::Superhero.name }
    ipdb_id { rand(1000..9999) }
  end
end
