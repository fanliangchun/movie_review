Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  resources :movies do
  	member do
  		post :favorite
  		post :unfavorite
      put "like", to: "movies#upvote"
      put "dislike", to: "movies#downvote"
  	end
    resources :reviews
  end

  namespace :account do
  	resources :favorites
    resources :reviews
  end
	root 'movies#index'
end
