class FollowsController < ApplicationController

	def index
		@user = User.find_by(:id => params["user_id"])
	end

	def new
		
	end

	def create
		
	end

	def destroy
		
	end


end