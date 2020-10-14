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
    @user = current_user
		@user.update(user_params)
    if @user.user_type == 0
      @user.update(company_id: nil)
    end
		redirect_to user_path(current_user), notice: "ユーザー情報の編集に成功しました。"
  end


  private

  def user_params
  	params.require(:user).permit(:name,:email,:icon_img)
  end

end
