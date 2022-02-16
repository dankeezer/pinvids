class MatchesController < ApplicationController
  def index
    @tournaments = Tournament.all

    render
  end
end
