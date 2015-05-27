class TweetsController < ApplicationController

	before_action :require_user, :only => [:index, :create, :destroy, :edit, :update]

	def require_user
		if session["user_id"].blank?
			redirect_to login_path, notice: "You need login to do something."
		end
	end


  # def find_user
  #   if (!session["user_id"].present?)
  #   	redirect_to login_path
  #   end
  # end
	
	def index
		if params["user_id"].present? && !params["fan_id"].present?
			@tweets = Tweet.where(user_id: params["user_id"]).order('date desc')
		
		# elsif !params["user_id"].present? && params["fan_id"].present?
		# 	# follow = Follow.where(fan_id: params["fan_id"])
		# 	follow = Follow.where(fan_id: params["fan_id"])
		# 	@tweets = Tweet.joins(follow).where(fan_id: params["fan_id"]).all.order('date desc')
		# 	# @tweets = Tweet.includes(:follow).where("follows.fan_id = ?", params["fan_id"])
		# 	# @tweets = @tweets.all.order('date desc')
		

		else
			@tweets = Tweet.all.order('date desc')
		end
	end

	def create
		tweet = Tweet.new
		tweet.content = params[:post_tweet]
		tweet.date = DateTime.now.to_i
		tweet.user_id = session["user_id"]
		tweet.save
		redirect_to root_path
	end

	def destroy
		Tweet.find_by(id: params["id"]).delete
		redirect_to root_path
	end

	def edit
		@tweet = Tweet.find_by(id: params["id"])
	end

	def update
		tweet = Tweet.find_by(id: params["id"])
		tweet.content = params["update_tweet"]
		tweet.image = params["image"]
		tweet.date = DateTime.now.to_i
		tweet.save
		redirect_to root_path
	end
end