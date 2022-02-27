require 'rails_helper'

describe Tournament do
  let!(:tournament) { build(:tournament) }

  context "#video_url"  do
    it "with a video id defined returns a URL" do
      expect(tournament.video_url).to eq "https://youtu.be/#{tournament.video_id}"
    end
  end

  context "#ifpa_url" do
    it "with an IFPA ID defined returns a URL" do
      expect(tournament.ifpa_url).to eq(
        "https://www.ifpapinball.com/tournaments/view.php?t=#{tournament.ifpa_id}#"
      )
    end

    it "without an IFPA ID defined returns a blank string" do
      tournament.ifpa_id = nil

      expect(tournament.ifpa_url).to eq ""
    end
  end
end
