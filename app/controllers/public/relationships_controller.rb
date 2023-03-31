class Public::RelationshipsController < ApplicationController
  # フォローするとき
  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_member.unfollow(params[:member_id])
    redirect_back(fallback_location: root_path)
  end
  # フォロー一覧
  def followings
    member = Member.find(params[:member_id])
    @members = member.following_member
  end
  # フォロワー一覧
  def followed
    member = Member.find(params[:member_id])
    @members = member.follower_member
  end
end
