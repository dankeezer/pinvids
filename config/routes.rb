Rails.application.routes.draw do
  root "welcome#show"

  resources "tournaments" do
    resources "matches"
  end

  resources "machines"
end
