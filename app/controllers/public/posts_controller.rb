class Public::PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    redirect_to about_path
  end

  def show
    @post = Post.find(params[:id])
    @member = @post.member
  end

  def edit
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
  end
end
