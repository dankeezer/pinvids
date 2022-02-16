class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :machine

  enum bracket: { qualifier: 0, quarterfinal: 1, semifinal: 2, final: 3 }
  validates :bracket, inclusion: { in: brackets.keys }

  def video_url
    "#{tournament.video_url}?t=#{video_segment_start_time_in_seconds.to_s}"
  end

  def video_embed_url
    "https://www.youtube.com/embed/#{tournament.video_id}?start=#{video_segment_start_time_in_seconds.to_s}"
  end

  def video_segment_start_time_in_seconds
    hours, minutes, seconds = video_segment_start_time.split(":")

    (hours.to_i * 3600) + (minutes.to_i * 60) + seconds.to_i
  end
end
