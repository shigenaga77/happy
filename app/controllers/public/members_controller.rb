class Public::MembersController < ApplicationController
  
  def show
    # @member = current_member
    @member = Member.find(params[:id])
  end

  def edit
    @member = current_member
  end
    
  def update
    @member = current_member
    @member.update(member_params)
    redirect_to member_path
  end
  
  def comfirm
    # @member = Member.find(params[:id])
    @member = current_member
  end
    
  def withdraw
    @member = current_member
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
  end
  
  private
  def member_params
    params.require(:member).permit(:profile_image, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :self_introduction)
  end
  
end
