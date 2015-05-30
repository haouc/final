class MessagesController < ApplicationController

	def index
		@user = User.find_by_id(session["user_id"])
	end

	def new
		
	end

	def create
		
	end

	def destroy
		
	end

end