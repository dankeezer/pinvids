FactoryBot.define do
  factory :match do
    tournament
    machine

    video_segment_start_time { [rand(10), rand(60), rand(60)].join(":") }
    bracket { rand(4) }
    invalidated { [true, false].sample }
    tournament_id { rand(10) }
    machine_id { rand(10) }
  end
end
