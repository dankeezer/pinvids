require 'rails_helper'

describe 'Machine', type: :request do
  let!(:machines) { create_list(:machine, 5) }
  let!(:tournaments) { create_list(:tournament, 5) }
  let!(:matches) { Match.all }

  before do
    3.times do
      create(
        :match,
        machine_id: machines.first.id,
        tournament_id: tournaments.sample.id
      )
    end
  end

  let(:params) { attributes_for(:machine) }

  describe '#index' do
    it "responds with all machines as @machines" do
      get machines_path

      expect(response).to have_http_status(200)
      expect(response.body).to include(machines.first.name)
    end
  end

  describe '#show' do
    it "responds with a requested machine as @machine" do
      get machine_path(machines.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(machines.last.name)
    end

    it "responds with a list of matches" do
      get machine_path(machines.first)

      expect(response).to have_http_status(200)
      expect(response.body).to include(matches.last.machine.name)
    end
  end

  describe '#new' do
    it "responds with a new machine form" do
      get new_machine_path

      expect(response).to have_http_status(200)
      expect(response.body).to include("New Machine")
    end
  end

  describe '#edit' do
    it "responds with an edit machine form for @machine" do
      get edit_machine_path(machines.last)

      expect(response).to have_http_status(200)
      expect(response.body).to include(machines.last.name)
    end
  end

  describe '#create' do
    describe "with valid params" do
      it "responds with a newly created machine as @machine" do
        post machines_path(machine: params)
        expect(Machine.last.name).to eq(params[:name])
      end

      it "redirects to the created machine" do
        post machines_path(machine: params)
        expect(response).to redirect_to(Machine.last)
      end
    end

    describe "with invalid params" do
      it "renders to the new machine page with errors" do
        post machines_path(machine: params.except(:name))
        expect(response.body).to include(CGI.escape_html("Name can't be blank"))
        expect(response.body).to include("New Machine")
      end
    end
  end

  describe '#update' do
    describe "with valid params" do
      it "updates the requested machine" do
        patch machine_path(machines.first, machine: params)
        expect(Machine.first.name).to eq(params[:name])
      end

      it "redirects to the updated machine" do
        patch machine_path(machines.first, machine: params)
        expect(response).to redirect_to(Machine.first)
      end
    end

    describe "with invalid params" do
      it "renders to the same edit machine page with errors" do
        patch machine_path(machines.first, machine: { name: nil })
        expect(response.body).to include(CGI.escape_html("Name can't be blank"))
        expect(response.body).to include("Edit #{machines.first.name}")
      end
    end
  end
end
