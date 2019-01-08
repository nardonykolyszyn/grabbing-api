# frozen_string_literal: true

Rails.application.routes.draw do
  jsonapi_resources :wrappers, only: :create
  get 'searches', to: 'links#index'
end
