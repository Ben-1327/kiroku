class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.limit(10).order('id DESC')
  end

  def edit
    @users = User.where(representative: false).page(params[:page]).reverse_order.per(12)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "successfully updated user!"
    else
      render :edit
    end
  end


  private

  def user_params
  	params.permit(:name,:email,:icon_img)
  end

end
