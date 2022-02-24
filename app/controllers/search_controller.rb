class SearchController < ApplicationController
  def index
    @machines, @tournaments = [[],[]]
    return render unless params[:query].present?

    @machines, @tournaments = search(params["query"])

    render
  end

  def new
    @machines, @tournaments = search(params["query"])

    render json: {
      machines: @machines,
      tournaments: @tournaments
    }.to_json
  end

  private

  def search(query)
    machines = Machine.where(["name ILIKE ?", "%#{query}%"])
    tournaments = Tournament.where(["name ILIKE ?", "%#{query}%"])

    machines += Machine.search(query) if machines.empty?
    tournaments += Tournament.search(query) if tournaments.empty?

    [machines.uniq.sort_by(&:name), tournaments.uniq.sort_by(&:name)]
  end
end
