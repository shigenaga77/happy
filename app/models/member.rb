class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォローをした、されたの関係
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :follower_member, through: :followed, source: :follower
  has_many :following_member, through: :follower, source: :followed
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
  
  # フォローしたときの処理
  def follow(member_id)
    follower.create(followed_id: member_id)
  end
  # フォローを外すときの処理
  def unfollow(member_id)
    follower.find_by(followed_id: member_id).destroy
  end
  # フォローしているか判定
  def following?(member)
    following_member.include?(member)
  end
  
end
