class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(username: params[:username], email: params[:email], password: params[:password])
		if @user.save
      redirect_to root_url, notice: "Thanks for signing up."
    else
      render "new"
    end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update

		@user = User.find_by(id: params[:id])
		@user.username = params[:username]
		@user.email = params[:email]
		@user.image = params[:image]

		if params[:password] == params[:repassword]
			@user.password = params[:password]
			if @user.save
				redirect_to user_path(params[:id])
			else
				render "edit"
			end
		else
			redirect_to edit_user_path(params[:id]), notice: "Password doesn't match the password stored in our system."
		end
	end
end