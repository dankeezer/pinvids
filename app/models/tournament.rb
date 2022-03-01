class Tournament < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: :name,
                  using: [:trigram],
                  ignoring: :accents

  has_many :matches
  has_many :machines, through: :matches

  validates :name,              presence: true
  validates :video_id,          presence: true
  validates :video_host,        presence: true
  validates :video_duration,    presence: true
  validates :event_started_at,  presence: true

  def video_url
    "https://youtu.be/#{video_id}"
  end

  def ifpa_url
    return "" if ifpa_id.blank?

    "https://www.ifpapinball.com/tournaments/view.php?t=#{ifpa_id}#"
  end
end
