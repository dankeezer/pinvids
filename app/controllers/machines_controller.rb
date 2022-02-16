class MachinesController < ApplicationController
  def index
    @machines = Machine.all.sort
    render
  end

  def show
    @machine = Machine.find(params[:id])
    @matches = Match.where(machine_id: params[:id]).
      sort_by { |m| [m.tournament_id, m.video_segment_start_time] }

    render
  end
end
