require 'rails_helper'

RSpec.describe 'Machine', type: :request do
  let!(:machines) { create_list(:machine, 3) }
  let!(:new_name) { Faker::Superhero.name }

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
        post machines_path(machine: { name: new_name })
        expect(Machine.last.name).to eq(new_name)
      end

      it "redirects to the created machine" do
        post machines_path(machine: { name: new_name })
        expect(response).to redirect_to(Machine.last)
      end
    end
  end

  describe '#update' do
    describe "with valid params" do
      it "updates the requested machine" do
        patch machine_path(machines.first, machine: { name: new_name })
        expect(Machine.first.name).to eq(new_name)
      end

      it "redirects to the updated machine" do
        patch machine_path(machines.first, machine: { name: new_name })
        expect(response).to redirect_to(Machine.first)
      end
    end
  end
end
