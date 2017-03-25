Rails.application.routes.draw do
  devise_for :users
  resources :movies do
  	member do
  		post :favorite
  		post :unfavorite
  	end
    resources :reviews
  end

  namespace :account do
  	resources :favorites
    resources :reviews
  end
	root 'movies#index'
end
