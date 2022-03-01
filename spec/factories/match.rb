FactoryBot.define do
  factory :match do
    tournament
    machine

    video_segment_start_time { [rand(10), rand(60), rand(60)].join(":") }
    bracket { Match.brackets.keys.sample }
    invalidated { [true, false].sample }
    tournament_id { rand(1..3) }
    machine_id { rand(1..3) }
  end
end
