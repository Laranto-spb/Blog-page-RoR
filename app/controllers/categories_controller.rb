class CategoriesController < ApplicationController
  before_action :require_admin, except: [:show, :index]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category was successfully added"
      redirect_to @category
    else
      render 'new'
    end

  end


  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category was deleted succesfully"
    redirect_to categories_path
    
  end

  def edit
    
  end

  def update
       
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully"
      redirect_to category_path(@category)
     else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end



  
end