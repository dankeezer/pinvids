require 'rails_helper'

RSpec.describe 'Match', type: :request do
  let!(:tournaments) { create_list(:tournament, 5) }
  let!(:machines) { create_list(:machine, 5) }
  let!(:matches) { Match.all }

  before do
    3.times do
      create(
        :match,
        machine_id: machines.sample.id,
        tournament_id: tournaments.sample.id
      )
    end
  end

  it "fun message for fun" do
    print "\n\nIn today's tests we're playing:\n"
    matches.each { |m| print "\n#{m.machine.name} at #{m.tournament.name}" }
    print "\n\n"
  end

  describe '#index' do
    xit "responds with all matches as @matches" do
    end
  end

  describe '#show' do
    it "responds with a requested match as @match" do
      get tournament_match_path(matches.last.tournament, matches.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(matches.last.tournament.name)
      expect(response.body).to include(matches.last.machine.name)
    end
  end

  describe '#new' do
    xit "responds with a new match form" do
      get new_match_path

      expect(response).to have_http_status(200)
      expect(response.body).to include("New Match")
    end
  end

  describe '#edit' do
    xit "responds with an edit match form for @match" do
      get edit_match_path(matches.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(matches.last.name)
    end
  end

  describe '#create' do
    describe "with valid params" do
      xit "responds with a newly created match as @match" do
        post matches_path(match: { name: new_name })
        expect(Match.last.name).to eq(new_name)
      end

      xit "redirects to the created match" do
        post matches_path(match: { name: new_name })
        expect(response).to redirect_to(Match.last)
      end
    end
  end

  describe '#update' do
    describe "with valid params" do
      xit "updates the requested match" do
        patch match_path(matches.first, match: { name: new_name })
        expect(Match.first.name).to eq(new_name)
      end

      xit "redirects to the updated match" do
        patch match_path(matches.first, match: { name: new_name })
        expect(response).to redirect_to(Match.first)
      end
    end
  end
end
