class Public::PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.published.all.order(created_at: :desc)
    @genre = Genre.all
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
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
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
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
  
  def comment_index
    @post = Post.find(params[:post_id])
    @member = @post.member
    @comment = Comment.new
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
  end
  
end
