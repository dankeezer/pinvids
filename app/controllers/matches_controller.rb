class MatchesController < ApplicationController
  def index
    render
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to tournament_path @match.tournament_id
    else
      flash.now[:messages] = @match.errors.full_messages
      render action: 'new', status: :unprocessable_entity
    end
  end

  def edit
    @match = Match.find(params[:id])

    render
  end

  def update
    @match = Match.find(params[:id])

    if @match.update(match_params)
      redirect_to action: 'show', id: @match
    else
      flash.now[:messages] = @match.errors.full_messages
      @match = Match.find(params[:id])
      render action: 'edit', status: :unprocessable_entity
    end
  end

  private

  def match_params
    params.require(:match).permit(
      :video_segment_start_time,
      :bracket,
      :invalidated,
      :machine_id,
      :tournament_id
    )
  end
end
