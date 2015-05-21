class TweetsController < ApplicationController

	before_action :find_user

  def find_user
    if (!cookies["user_id"].present?)
    	redirect_to login_path
    end
  end
	
	def index
		@tweets = Tweet.all.order('date desc')
	end

	def create
		tweet = Tweet.new
		tweet.content = params[:post_tweet]
		tweet.date = DateTime.now.to_i
		tweet.user_id = cookies["user_id"]
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