class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show , :destroy]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :user_profile, only: [:edit, :update, :destroy]

  def new 
    @user = User.new
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
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
      redirect_to @user
     else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if !current_user.admin?
    flash[:notice] = "#{@user.username} 's account was successfully deleted with all your articles"
    redirect_to articles_path
  end



  private 

  def set_user
    @user = User.find(params[:id])
  end


  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

  
end