# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :users do
      collection do
        post 'login'
        get 'auto_login'
      end
    end
    resources :study_lists
    get 'study_lists/:id/new_game', to: 'study_lists#new_game'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
