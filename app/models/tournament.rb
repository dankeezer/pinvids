class Tournament < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: :name,
                  using: [:trigram],
                  ignoring: :accents

  has_many :matches
  has_many :machines, through: :matches

  def video_url
    "https://youtu.be/#{video_id}"
  end

  def ifpa_url
    return "" if ifpa_id.blank?

    "https://www.ifpapinball.com/tournaments/view.php?t=#{ifpa_id}#"
  end
end
