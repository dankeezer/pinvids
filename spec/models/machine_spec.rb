require 'rails_helper'

describe Machine do
  let!(:machine) { build(:machine) }

  context "#ipdb_url" do
    it "with an IPDB ID defined returns a URL" do
      expect(machine.ipdb_url).to eq "https://www.ipdb.org/machine.cgi?id=#{machine.ipdb_id}#"
    end

    it "without an IPDB ID defined returns a blank string" do
      machine.ipdb_id = nil

      expect(machine.ipdb_url).to eq ""
    end
  end
end
