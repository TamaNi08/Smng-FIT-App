Rails.application.routes.draw do
  devise_for :admin_users
  get "top" => "evacuation#top"
  get "top/map" => "evacuation#map"
  get "top/table" => "evacuation#table"
  # get 'users/new'
  resources :users
  root to: 'shelters#index'
  resources :shelters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #Serch用のコード
  resources :users do
    collection do
      get 'search'
    end
  end
  #ここまで


end