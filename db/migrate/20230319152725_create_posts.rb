class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id
      t.integer :genre_id, null: false
      t.integer :favorite_id
      t.integer :comment_id
      t.string :title, null: false
      t.string :body, null: false
      t.string :post_status, null: false
      t.timestamps
    end
  end
end
