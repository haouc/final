class SessionsController < ApplicationController

	def new

	end

  def create
    user = User.find_by(email: params[:email])
    if user
      if user.password == params[:password]
        cookies["user_id"] = user.id
        cookies["username"] = user.username
        cookies["user_image"] = user.image
        redirect_to root_url, notice: "Welcome back!"
      else
        redirect_to root_url, notice: "Password error."
      end
    else
      redirect_to root_url, notice: "Unknown email."
    end
  end

  def destroy
		cookies.delete :user_id
		redirect_to root_url, notice: "Thanks for visiting" 	
  end
end