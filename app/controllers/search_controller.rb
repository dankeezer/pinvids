class SearchController < ApplicationController
  def index
    @machines_and_tournaments = (Machine.all + Tournament.all).map do |i|
      [i.model_name.route_key, i.name, i.id]
    end

    return render unless params[:query].present?

    search = PgSearch.multisearch(params[:query])
    @search_results = search.map { |s| s.searchable_type.constantize.find(s.searchable_id) }

    render
  end
end
