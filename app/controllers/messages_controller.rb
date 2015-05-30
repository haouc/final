class MessagesController < ApplicationController

	before_action :find_user
	def find_user
		if (!session["user_id"].present?)
			redirect_to login_path
		end
	end


	def index
		@user = User.find_by_id(session["user_id"])
		if params["user_id"].present?
			@messages = Message.where(sender_id: params["user_id"])
		end
		@messages = @messages.order('date desc').paginate(:per_page => 5, :page => params[:page])
	end

	def new
		
	end

	def create
		message = Message.new
		message.receiver_id = params[:receiver]
		message.content = params[:message]
		message.date = DateTime.now.to_i
		message.sender_id = session["user_id"]
		message.is_read = false
		message.save
		redirect_to root_path
	end

	def destroy
		
	end

end