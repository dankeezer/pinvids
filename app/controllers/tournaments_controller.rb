class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all.sort_by(&:event_started_at).reverse
    render
  end

  def show
    @tournament = Tournament.find(params[:id])
    @matches = @tournament.matches.sort_by(&:video_segment_start_time)

    render
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      redirect_to action: 'show', id: @tournament
    else
      flash.now[:messages] = @tournament.errors.full_messages
      render action: 'new', status: :unprocessable_entity
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])

    render
  end

  def update
    @tournament = Tournament.find(params[:id])

    if @tournament.update(tournament_params)
      redirect_to action: 'show', id: @tournament
    else
      flash.now[:messages] = @tournament.errors.full_messages
      @tournament = Tournament.find(params[:id])
      render action: 'edit', status: :unprocessable_entity
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(
      :name,
      :video_id,
      :video_host,
      :video_duration,
      :ifpa_id,
      :event_started_at
    )
  end
end
