Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :users do
      collection do
        post 'login'
      end
    end
    resources :study_lists
    get 'study_lists/:id/new_game', to: 'study_lists#new_game'
    get 'study_lists/:study_list_id/words', to: 'words#index'
    get 'words/:word_id/synonyms', to: 'synonyms#index'
    post 'study_lists/:id/words', to: 'study_lists#add_words'
    get 'words/search', to: 'words#search'
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
