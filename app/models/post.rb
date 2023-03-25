class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :member
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
