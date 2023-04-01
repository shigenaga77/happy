class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :member
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  
  with_options presence: true, on: :publicize do
    validates :genre_id
    validates :title
    validates :body
  end
    validates :title, length: { maximum: 14 }, on: :publicize
    validates :body, length: { maximum: 80 }, on: :publicize
end
