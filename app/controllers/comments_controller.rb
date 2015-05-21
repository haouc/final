class CommentsController < ApplicationController

	def create
		comment = Comment.new
		comment.content = params[:comment]
		comment.tweet_id = params[:tweet_id]
		comment.date = DateTime.now.to_i
		comment.user_id = cookies["user_id"]
		comment.save
		redirect_to root_path
	end
		
	def destroy
		Comment.find_by(id: params[:id]).delete
		redirect_to root_path
	end
end