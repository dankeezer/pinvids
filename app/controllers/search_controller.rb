class SearchController < ApplicationController
  def index
    return render unless params[:search].present?

    search = PgSearch.multisearch(params[:search])
    @search_results = search.map { |s| s.searchable_type.constantize.find(s.searchable_id) }

    render
  end
end
