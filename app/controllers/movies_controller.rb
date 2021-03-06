class MoviesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :find_movie, only: [:edit, :update, :destroy]

	def index
		@movies = Movie.all
	end

	def show
		@movie = Movie.find(params[:id])
		@reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
	end

	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.new(movie_params)
		@movie.user = current_user
		if @movie.save
			redirect_to movies_path, notice: "Created Successfully!"
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @movie.update(movie_params)
			redirect_to movie_path, notice: "Updated Successfully!"
		end
	end

	def destroy
		@movie.destroy
		redirect_to root_path, warning: "Moive Deleted!"
	end

	def favorite
		@movie = Movie.find(params[:id])
		if !current_user.has_favorited?(@movie)
			current_user.favorite!(@movie)
			flash[:notice] = "Favorited Successfully! "
		else
			flash[:alert] = "Already Favorited!"
		end

		redirect_to :back
	end

	def unfavorite
		@movie = Movie.find(params[:id])
		if current_user.has_favorited?(@movie)
			current_user.unfavorite!(@movie)
			flash[:warning] = "Unfavorited Successfully!"
		end
		redirect_to :back
	end

	def upvote
    @movie = Movie.find(params[:id])
    @movie.upvote_by current_user
    redirect_to :back
	end

	def downvote
    @movie = Movie.find(params[:id])
    @movie.downvote_by current_user
    redirect_to :back
	end

	private

	def find_movie
		@movie = Movie.find(params[:id])

		if current_user != @movie.user
			flash[:alert] = "You have no permission!"
			redirect_to root_path
		end
	end

	def movie_params
		params.require(:movie).permit(:title, :description, :director, :movie_length, :avatar)
	end
end
