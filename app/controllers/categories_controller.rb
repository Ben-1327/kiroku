class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @categories = @user.categories.page(params[:page]).reverse_order
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
  	if @category.save
  		redirect_to user_categories_path(current_user), notice: "登録に成功しました!"
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
  		redirect_to user_categories_path(current_user), notice: "更新に成功しました!"
  	else
  		render :edit
  	end
  end

  def show
    @category = Category.find(params[:id])
    @user = @category.user
    @posts = Post.where(category_id: @category.id, user_id: @user.id)
  end


  private

  def category_params
    params.require(:category).permit(:user_id, :name)
  end

end
