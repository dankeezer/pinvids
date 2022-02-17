class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all.sort_by(&:event_started_at)
    render
  end

  def show
    @tournament = Tournament.find(params[:id])
    @matches = Match.where(tournament_id: params[:id]).sort_by(&:video_segment_start_time)

    render
  end
end
