class Public::MembersController < ApplicationController
  before_action :is_matching_login_member, only: [:edit, :update]
  
  def show
    @main_background_image = "background-image3"
    @member = Member.find(params[:id])
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    @my_posts = @member.posts.page(params[:page]).order(created_at: :desc).per(3)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
  def edit
    @main_background_image = "background-image3"
    @member = Member.find(params[:id])
  end
    
  def update
    @main_background_image = "background-image3"
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path
  end
  
  def comfirm
    @main_background_image = "background-image3"
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
    @main_background_image = "background-image3"
    @member = Member.find(params[:id])
    favorites= Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @pick_posts = Post.published.all.order(created_at: :desc).limit(1)
    # 投稿のいいね数ランキング
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
  
  private
  def member_params
    params.require(:member).permit(:profile_image, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :self_introduction)
  end
  
  def is_matching_login_member
    member = Member.find(params[:id])
    unless member.id == current_member.id
      redirect_to posts_path
    end
  end
  
end
