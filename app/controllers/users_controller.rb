class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show ]

  def new 
    @user = User.new
  end

  def show
    @articles = @user.articles
  end

  def index
    @users = User.all
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

  def edit
    
  end

  def update
    
    if @user.update(users_params)
      flash[:notice] = "Your profile updated successfully"
      redirect_to articles_path
     else
      render 'edit'
    end
  end


  private 

  def set_user
    @user = User.find(params[:id])
  end


  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

  
end