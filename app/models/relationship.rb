class Relationship < ApplicationRecord
    # memberへのアソシエーション
    # class_nameがmemberモデルとリンクしている(class_nameは大文字でなければNG）
    belongs_to :followed, class_name: "Member"
    belongs_to :follower, class_name: "Member"
end
