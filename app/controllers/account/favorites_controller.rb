class Account::FavoritesController < ApplicationController
	before_action :authenticate_user!
	def index
		@movies = current_user.favorited_movies.order("id DESC")
	end
end
