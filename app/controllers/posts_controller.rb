class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.category_id = current_user.categories.find_by(id: params[:category_id]).id
  	if @post.save
  		redirect_to user_post_path(@post), notice: "投稿に成功しました!"
  	else
  		@user = User.find(params[:id])
  		render 'users/show'
  	end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  	if @post.update(post_params)
  		redirect_to user_post_path(current_user, @post), notice: "更新に成功しました!"
  	else
  		render :edit
  	end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :content, :quotation, :memo)
  end

end
