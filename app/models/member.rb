class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # 自分がフォローをしたり、外したりする記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #sourceは本当はfollow_idとなっていてカラム名を示している。#フォロー一覧を表示するための記述
  has_many :followings, through: :relationships, source: :followed
  
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  #フォロワー一覧を表示するための記述
  has_many :followers, through: :reverse_relationships, source: :follower
  has_one_attached :profile_image
         
  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， member.name = "ゲスト" なども必要
      member.last_name = ""
      member.first_name = "guest"
      member.last_name_kana = ""
      member.first_name_kana = ""
      member.nickname = ""
    end
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def follow(member_id)
    favorites.create(follow_id: member_id)
  end

  def unfollow(member_id)
    favorites.find_by(follow_id: member_id).destroy
  end
  
end
