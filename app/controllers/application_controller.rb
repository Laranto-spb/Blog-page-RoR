class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !current_user
      flash[:alert] = "Please, log in before any actions"
      redirect_to login_path
    end
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Sorry, but only admins can create/edit/delete categories"
      redirect_to categories_path
    end
  end

  def user_article
    if  current_user != @article.user && !current_user.admin? 
      flash[:alert] = "You can edit only your own article"
      redirect_to @article
    end
  end

  def user_profile
    if  current_user != @user && !current_user.admin?
      flash[:alert] = "You can edit only your own profile"
      redirect_to @user
    end
  end


end
