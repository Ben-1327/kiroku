class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @categories = @user.categories.page(params[:page]).reverse_order
  end

  def show
    @category = Category.find(params[:id])
    @user = @category.user
    @posts = Post.where(category_id: @category.id, user_id: @user.id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
  	if @category.save
  		redirect_to user_categories_path(current_user), notice: "Posted successfully!"
  	else
  		@user = User.find(params[:id])
  		render 'users/show'
  	end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
  	if @category.update(category_params)
  		redirect_to user_categories_path(current_user), notice: "Updated successfully!"
  	else
  		render :edit
  	end
  end

  def destroy
    @category = Category.find(params[:id])
  	@category.destroy
  	redirect_to user_categories_path(current_user), notice: "Deleted successfully!"
  end


  private

  def category_params
    params.require(:category).permit(:user_id, :name)
  end

end
