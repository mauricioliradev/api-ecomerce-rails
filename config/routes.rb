# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders
      resources :products
      post '/reports' => 'reports#ticket'
    end
  end
end
