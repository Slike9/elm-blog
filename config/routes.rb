Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'web/welcome#index'

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index]
    end
  end

  get '*path', to: 'web/welcome#index'
end
