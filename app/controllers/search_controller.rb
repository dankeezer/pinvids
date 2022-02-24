class SearchController < ApplicationController
  def index
    return render unless params["query"].present?

    @machines, @tournaments = search(params["query"])

    if request.content_type == "application/json"
      render json: {
        machines: @machines,
        tournaments: @tournaments
      }.to_json
    else
      render # html
    end
  end

  private

  def search(query)
    # Four DB queries is a lot for inline JS, we can cache it if there's a performance hit.

    machines = Machine.where(["name ILIKE ?", "%#{query}%"])
    tournaments = Tournament.where(["name ILIKE ?", "%#{query}%"])

    machines += Machine.search(query)
    tournaments += Tournament.search(query)

    [machines.uniq.sort_by(&:name), tournaments.uniq.sort_by(&:event_started_at).reverse]
  end
end
