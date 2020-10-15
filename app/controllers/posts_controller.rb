class PostsController < ApplicationController

  before_action :authenticate_user!

  def new
    @posts = Post.new
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

end
