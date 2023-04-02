class Public::PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    # 投稿ボタンを押下した場合
    if params[:post]
      if @post.save(context: :publicize)
        redirect_to about_path
      else
        render :index, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
      # 下書きボタンを押下した場合
    else
      if @post.update
        redirect_to member_path(current_member), notice: "レシピを下書き保存しました！"
      else
        render :index, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
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
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
  end
  
end
