class MachinesController < ApplicationController
  def index
    @machines = Machine.all.sort_by(&:name)
    render
  end

  def show
    @machine = Machine.find(params[:id])
    @matches = Match.where(machine_id: params[:id]).
      sort_by { |m| [m.tournament_id, m.video_segment_start_time] }

    render
  end

  def new
     @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)

    if @machine.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
     @machine = Machine.find(params[:id])

     render
  end

  def update
    @machine = Machine.find(params[:id])

    if @machine.update!(machine_params)
      redirect_to :action => 'show', :id => @machine
    else
      render :action => 'edit'
    end
  end

  private

  def machine_params
    params.require(:machine).permit(:name, :ipdb_id)
  end
end