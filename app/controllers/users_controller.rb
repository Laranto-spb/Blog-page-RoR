class UsersController < ApplicationController

  def new 
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:notice] = "Welcome, #{@user.username}! You signed up successfully"
      redirect_to articles_path
    else 
      render 'new'
    end
  end

  private 

  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

  
end