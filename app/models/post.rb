class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :member
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  
  enum post_status: { published: 0, draft: 1 }
  
end
