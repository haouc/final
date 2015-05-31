class FollowsController < ApplicationController

	before_action :find_user
	def find_user
		if (!session["user_id"].present?)
			redirect_to login_path
		end
	end

	def index
		@user = User.find_by(:id => params["user_id"])
	end

	def new
		
	end

	def create
		follow = Follow.new
		# if params[:star] == session["user_id"]
		# 	redirect_to root_path, notice: "You can't follow yourself!"
		# 	return
		# end
		if User.find_by_id(params[:star]).present? && !Follow.find_by_star_id(params[:star]).present?
			follow.star_id = params[:star]  
			follow.fan_id = session["user_id"]
			if follow.star_id == follow.fan_id
			redirect_to root_path, notice: "You can't follow yourself!"
			return
			end
			follow.save
			redirect_to root_path, notice: "You are following this ID successfully."
			
		elsif !User.find_by_id(params[:star]).present?
			redirect_to root_path, notice: "No such user existing!"

		else
			redirect_to root_path, notice: "You are already following this ID."
		end
	end

	# def create
	# 	follow = Follow.new

	# 	if Follow.find_by_star_id(params[:star]).present?
	# 		redirect_to root_path, notice: "You are already following this ID."

	# 	elsif !User.find_by_id(params[:star]).present?
	# 		redirect_to root_path, notice: "No such user existing!"

	# 	elsif User.find_by_id(params[:star]).present? && !Follow.find_by_star_id(params[:star]).present?
	# 		follow.star_id = params[:star]  
	# 		follow.fan_id = session["user_id"]
	# 		follow.save
	# 		redirect_to root_path, notice: "You are following this ID successfully."
	# 	end
	# end

	def destroy

		# Message.find_by_id(msg_id).delete
		if Follow.find_by_id(params[:id]).present?
			Follow.find_by_id(params[:id]).delete
		end
		redirect_to root_path
	end


end