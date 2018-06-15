Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root 'site/home#index'

  get 'backoffice', to: 'backoffice/dashboard#index'

  namespace :backoffice do
    get 'dashboard', to: 'dashboard#index'

    resources :send_mail, only: [:edit, :create]
    resources :categories, except: [:show, :destroy]
    resources :admins, except: [:show]
    resources :diagrams, only: [:index]
  end

  namespace :site do
    get 'home', to: 'home#index'
    get 'search', to: 'search#ads'

    resources :ad_detail, only: [:show]
    resources :categories, only: [:show]
    resources :comments, only: [:create]

    namespace :profile do
      resources :dashboard, only: [:index]
      resources :ads, only: [:index, :edit, :update, :new, :create]
    end

  end

  devise_for :admins, :skip => [:registrations]
  devise_for :members, controllers: {sessions: 'members/sessions'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
