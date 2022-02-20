class SearchController < ApplicationController
  def index
    return render unless params[:query].present?

    search = PgSearch.multisearch(params[:query])
    @search_results = search.map { |s| s.searchable_type.constantize.find(s.searchable_id) }

    @machines = Machine.all.map { |m| m.name }

    render
  end
end
