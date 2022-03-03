require 'rails_helper'

describe 'Tournament', type: :request do
  let!(:tournaments) { create_list(:tournament, 3) }
  let(:params) { attributes_for(:tournament) }

  describe '#index' do
    it "responds with all tournaments as @tournaments" do
      get tournaments_path

      expect(response).to have_http_status(200)
      expect(response.body).to include(CGI.escape_html(tournaments.first.name))
    end
  end

  describe '#show' do
    it "responds with a requested tournament as @tournament" do
      get tournament_path(tournaments.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(CGI.escape_html(tournaments.last.name))
    end
  end

  describe '#new' do
    it "responds with a new tournament form" do
      get new_tournament_path

      expect(response).to have_http_status(200)
      expect(response.body).to include("New Tournament")
    end
  end

  describe '#edit' do
    it "responds with an edit tournament form for @tournament" do
      get edit_tournament_path(tournaments.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(CGI.escape_html(tournaments.last.name))
    end
  end

  describe '#create' do
    describe "with valid params" do
      it "responds with a newly created tournament as @tournament" do
        post tournaments_path(tournament: params)
        expect(Tournament.last.name).to eq(params[:name])
      end

      it "redirects to the created tournament" do
        post tournaments_path(tournament: params)
        expect(response).to redirect_to(Tournament.last)
      end
    end

    describe "with invalid params" do
      it "renders to the new tournament page with errors" do
        post tournaments_path(tournament: params.except(:name))
        expect(response.body).to include(CGI.escape_html("Name can't be blank"))
        expect(response.body).to include("New Tournament")
      end
    end
  end

  describe '#update' do
    describe "with valid params" do
      it "updates the requested tournament" do
        patch tournament_path(tournaments.first, tournament: params)
        expect(Tournament.first.name).to eq(params[:name])
      end

      it "redirects to the updated tournament" do
        patch tournament_path(tournaments.first, tournament: params)
        expect(response).to redirect_to(Tournament.first)
      end
    end

    describe "with invalid params" do
      it "renders to the same edit tournament page with errors" do
        patch tournament_path(tournaments.first, tournament: { name: nil })
        expect(response.body).to include(CGI.escape_html("Name can't be blank"))
        expect(response.body).to include("Edit #{tournaments.first.name}")
      end
    end
  end
end
