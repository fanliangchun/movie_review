Rails.application.routes.draw do
  devise_for :users
  resources :movies do
  	member do
  		post :favorite
  		post :unfavorite
  	end
  end

  namespace :account do
  	resources :favorites
  end
	root 'movies#index'
end
