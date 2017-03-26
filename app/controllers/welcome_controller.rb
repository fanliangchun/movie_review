class WelcomeController < ApplicationController
	def index
		flash[:notice] = "Welcome to Chatting-Moives! CLick here to <a href='#{url_for(new_user_registration_path)}'> Sign Up</a>!".html_safe
	end
end
