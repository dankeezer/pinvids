require 'rails_helper'

describe Player, type: :model do
  let!(:player) { build(:player) }

  context "#name" do
    it "returns a full name" do
      expect(player.name).to eq "#{player.first_name} #{player.last_name}"
    end
  end
end
