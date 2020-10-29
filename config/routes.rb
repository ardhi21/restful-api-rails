Rails.application.routes.draw do
  resources :doctors do
    resources :schedules
  end

  resources :hospitals
end
