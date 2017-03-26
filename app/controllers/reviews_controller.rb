class ReviewsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :new, :destroy]


	def new
		@movie = Movie.find(params[:movie_id])
		@review = Review.new
	end

	def create
		@movie = Movie.find(params[:movie_id])
		@movie.user = current_user
		@review = Review.new(review_params)
		@review.movie = @movie

		if @review.save
			redirect_to @movie
		else
			render :new
		end
	end

	def destroy
		@movie = Movie.find(params[:movie_id])
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to movie_path(@movie)
	end

	private
	def review_params
		params.require(:review).permit(:comment)
	end
end
