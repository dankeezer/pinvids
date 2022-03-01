require 'rails_helper'

describe 'Match', type: :request do
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

  let(:params) do
    attributes_for(
      :match,
      machine_id: machines.map(&:id).sample,
      tournament_id: tournaments.map(&:id).sample
    )
  end

  it "fun message for fun" do
    print "\n\nIn today's tests we're playing:\n"
    matches.each { |m| print "\n#{m.machine.name} at #{m.tournament.name}" }
    print "\n\n"
  end

  describe '#index' do
    it "responds with a link to create a new match" do
      get tournament_matches_path(matches.last.tournament.id)

      expect(response).to have_http_status(200)
      expect(response.body).to include("New Match")
    end
  end

  describe '#show' do
    it "responds with a requested match as @match" do
      get tournament_match_path(matches.last.tournament, matches.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(CGI.escape_html(matches.last.tournament.name))
      expect(response.body).to include(CGI.escape_html(matches.last.machine.name))
    end
  end

  describe '#new' do
    it "responds with a new match form" do
      get new_tournament_match_path(matches.last.tournament.id)

      expect(response).to have_http_status(200)
      expect(response.body).to include("New Match")
    end
  end

  describe '#edit' do
    it "responds with an edit match form for @match" do
      get edit_tournament_match_path(matches.last.tournament.id, matches.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(matches.last.id.to_s)
    end
  end

  describe '#create' do
    describe "with valid params" do
      it "responds with a newly created match as @match" do
        post tournament_matches_path(Match.last.tournament.id, match: params)

        expect(Match.count).to eq 4
      end

      it "redirects to the created match" do
        post tournament_matches_path(Match.first.tournament.id, match: params)
        expect(response).to redirect_to(Match.last.tournament)
      end
    end

    describe "with invalid params" do
      it "renders to the new match page with errors" do
        post tournament_matches_path(
          Match.last.tournament.id,
          match: params.except(:video_segment_start_time)
        )
        expect(response.body).to include(CGI.escape_html("Video segment start time can't be blank"))
        expect(response.body).to include("New Match")
      end
    end
  end

  describe '#update' do
    describe "with valid params" do
      it "updates the requested match" do
        patch tournament_match_path(
          matches.first.tournament.id,
          matches.first.id,
          match: params
        )
        expect(Match.first.video_segment_start_time).to eq(params[:video_segment_start_time])
      end

      it "redirects to the updated match" do
        patch tournament_match_path(
          matches.first.tournament.id,
          matches.first.id,
          match: params
        )
        expect(response).to redirect_to(
          tournament_match_path(matches.first.tournament.id, matches.first.id)
        )
      end
    end

    describe "with invalid params" do
      it "renders to the same edit match page with errors" do
        patch tournament_match_path(
          matches.first.tournament.id,
          matches.first.id,
          match: { video_segment_start_time: nil }
        )
        expect(response.body).to include(CGI.escape_html("Video segment start time can't be blank"))
        expect(response.body).to include("Edit Match #{matches.first.id}")
      end
    end
  end
end
