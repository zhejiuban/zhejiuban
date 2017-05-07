Rails.application.routes.draw do
  mount PgHero::Engine, at: "pghero"
  namespace :admin do
    resources :settings
  end
end
