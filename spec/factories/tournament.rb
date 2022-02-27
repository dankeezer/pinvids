FactoryBot.define do
  factory :tournament do
    name do
      ([Faker::Time.backward(days: 2555).year] +
        Faker::Hipster.words.map(&:capitalize)).join(" ")
    end
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    video_host { ["youtube"].sample }
    video_duration { [rand(10), rand(60), rand(60)].join(":") }
    ifpa_id { rand(1000..9999) }
    event_started_at { Faker::Time.backward(days: 2555) }
  end
end
