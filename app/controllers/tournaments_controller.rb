class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
    render
  end

  def show
    @tournament = Tournament.find(params.id)

    render
  end
end
