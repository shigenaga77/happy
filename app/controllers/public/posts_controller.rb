class Public::PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.published.all
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
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def search
    if params[:keyword].present?
      @post = Post.where('title LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @post = Post.all
    end
  end
  
  def drafts
    @posts = current_member.posts.draft.all
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
  end
  
end
