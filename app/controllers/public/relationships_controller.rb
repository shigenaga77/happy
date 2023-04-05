class Public::RelationshipsController < ApplicationController
  # フォローアンフォロー処理
  def create
    # params[:member_id]これはリンクから送られてきたmember_idをparamsで受け取っている
    # そして受け取った値をモデルのメソッドに受け渡している
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])
    #フォローの通知機能
    # @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  # フォローフォロワー一覧処理
  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end
end
