class Public::MembersController < ApplicationController
  
  def show
    @member = Member.find(params[:id])
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    @my_posts = current_member.posts.page(params[:page]).order(created_at: :desc).per(5)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @main_background_image = "background-image3"
  end
  
  def edit
    @member = Member.find(params[:id])
  end
    
  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path
  end
  
  def comfirm
    @member = Member.find(params[:id])
  end
    
  def withdraw
    @member = Member.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  
  def likes
    @member = Member.find(params[:id])
    favorites= Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
  end
  
  
  private
  def member_params
    params.require(:member).permit(:profile_image, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :self_introduction)
  end
  
end
