Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :users do
      collection do
        post 'login'
      end
    end
    resources :study_lists
    post 'study_lists/:id/game', to: 'study_lists#game'
    get 'study_lists/:study_list_id/words', to: 'words#index'
    get 'study_lists/:study_list_id/words/synonyms', to: "synonyms#index"
    resource :synonyms
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
