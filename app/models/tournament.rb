class Tournament < ApplicationRecord
  has_many :matches

  def video_url
    "https://youtu.be/#{self.video_id}"
  end

  def ifpa_url
    "https://www.ifpapinball.com/tournaments/view.php?t=#{self.ifpa_id.to_s}#"
  end
end
