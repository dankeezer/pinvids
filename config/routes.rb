Rails.application.routes.draw do
  root "search#index"

  get 'search' => 'search#index'

  resources "tournaments" do
    resources "matches"
  end

  resources "machines"
end
