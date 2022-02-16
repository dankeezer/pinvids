class Tournament < ApplicationRecord
  has_many :matches

  def video_url
    "https://youtu.be/#{video_id}"
  end

  def ifpa_url
    return "" if ifpa_id.blank?

    "https://www.ifpapinball.com/tournaments/view.php?t=#{ifpa_id.to_s}#"
  end

  def machines
    matches.map { |match| match.machine }.uniq.sort_by(&:name)
  end
end
