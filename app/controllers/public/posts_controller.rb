class Public::PostsController < ApplicationController
  before_action :is_matching_login_member, only: [:edit, :update]
  def index
    @main_background_image = "background-image3"
    @post = Post.new
    @posts = Post.published.page(params[:page]).order(created_at: :desc)
    @genre = Genre.all
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "投稿が成功しました。"
      redirect_to posts_path
    else
      @posts = Post.published.page(params[:page]).order(created_at: :desc)
      @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
      # 投稿のいいね数ランキング
      @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
      render :index
    end
  end

  def show
    @main_background_image = "background-image3"
    @post = Post.find(params[:id])
    @member = @post.member
    @comment = Comment.new
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def edit
    @main_background_image = "background-image3"
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @main_background_image = "background-image3"
    if params[:keyword].present?
      @post = Post.published.where('title LIKE ? OR body LIKE ? OR genre_id LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @post = Post.all
    end
  end

  def drafts
    @main_background_image = "background-image3"
    @posts = current_member.posts.draft.all
  end

  def comment_index
    @main_background_image = "background-image3"
    @post = Post.find(params[:post_id])
    @member = @post.member
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
  end

  def is_matching_login_member
    @posts = current_member.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end

end
