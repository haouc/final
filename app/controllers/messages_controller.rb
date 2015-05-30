class MessagesController < ApplicationController

	before_action :find_user
	def find_user
		if (!session["user_id"].present?)
			redirect_to login_path
		end
	end

	before_action :authorize, only: [:edit, :destroy, :update]
	def authorize
		@message = Message.find_by(id: params["id"])
		@user = User.find_by(id: @message.sender_id)
		if @user.blank? || session[:user_id] != @user.id
			redirect_to root_url, notice: "You need login!"
		end
	end

	def index
		@user = User.find_by_id(session["user_id"])
		if params["user_id"].present?
			@messages = Message.where(sender_id: params["user_id"])
			@messages_in = Message.where(receiver_id: session["user_id"])
		end
		@messages = @messages.order('date desc').paginate(:per_page => 5, :page => params[:page])
		@messages_in = @messages_in.order('date desc').paginate(:per_page => 5, :page => params[:page])
	end

	def new
		
	end

	def create
		message = Message.new
		message.receiver_id = User.find_by_username(params[:receiver]).id
		message.content = params[:message]
		message.date = DateTime.now.to_i
		message.sender_id = session["user_id"]
		message.is_read = false
		if message.receiver_id.present?
			message.save
		# else
		# 	rerender create, notice: "user is not exiting!"
		end
		redirect_to root_path
	end

	def destroy
		@message.delete
		redirect_to root_path
	end

end