class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)

    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      @error = false
      flash[:notice] = "You are logged in"
      redirect_to user_path(user.id)

    else
      @error = true
      flash.now[:alert] = "Something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
  
end