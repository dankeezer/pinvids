require 'rails_helper'

RSpec.describe Match, type: :model do
  let!(:tournament) { create(:tournament) }
  let!(:machine) { create(:machine) }
  let!(:match) { build(:match, machine_id: machine.id, tournament_id: tournament.id) }

  it "#video_url" do
    expect(match.video_url).to eq(
      "#{tournament.video_url}?t=#{match.video_segment_start_time_in_seconds}"
    )
  end

  it "#video_embed_url" do
    expect(match.video_embed_url).to eq(
      "https://www.youtube.com/embed/#{tournament.video_id}?" \
      "start=#{match.video_segment_start_time_in_seconds}"
    )
  end
end
