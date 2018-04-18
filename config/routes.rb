Rails.application.routes.draw do
  jsonapi_resources :wrappers
  resources :links, only: [:index]
end
