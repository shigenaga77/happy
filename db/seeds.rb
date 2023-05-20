# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'adminadmin'
)

members = Member.create!(
   [
      {
         email: 'tanaka@tarou.com',
         password: 'tanakatarou', 
         last_name: '太郎', 
         first_name: '田中', 
         last_name_kana: 'タロウ', 
         first_name_kana: 'タナカ', 
         nickname: 'たろうくん', 
         self_introduction: 'こんにちは。田中太郎です。'
         
      },
      {
         email: 'satou@hikaru.com', 
         password: 'satouhikaru', 
         last_name: '光', 
         first_name: '佐藤', 
         last_name_kana: 'ヒカル', 
         first_name_kana: 'サトウ', 
         nickname: 'ひかるくん', 
         self_introduction: 'こんにちは。佐藤光です。'
         
      },
      {
         email: 'nakamura@kaito.com', 
         password: 'nakamurakaito', 
         last_name: '海斗', 
         first_name: '中村', 
         last_name_kana: 'カイト', 
         first_name_kana: 'ナカムラ', 
         nickname: 'かいとくん', 
         self_introduction: 'こんにちは。中村海斗です。'
         
      },
      {
         email: 'mimura@yui.com', 
         password: 'mimurayui', 
         last_name: '由衣', 
         first_name: '三村', 
         last_name_kana: 'ユイ', 
         first_name_kana: 'ミムラ', 
         nickname: 'ゆいちゃん', 
         self_introduction: 'こんにちは。三村由衣です。'
         
      }   
   ]
)

genres = Genre.create!(
   [
      {name: '生活'},
      {name: 'アドバイス'},
      {name: '子供'}
   ]
)

Post.create!(
  [
    { 
      title: 'ピクニック',
      body: '今日は〇〇公園までピクニックに行ってきた！',
      image: ActiveStorage::Blob.create_and_upload!(
        io: File.open("#{Rails.root}/app/assets/images/5.jpg"),
        filename: "5.jpg"
      ),
      member_id: members[0].id,
      genre_id: genres[0].id 
    },
    {
      title: '節約',
      body: '今日は〇〇スーパーで肉が安くなってるからおすすめ！',
      image: ActiveStorage::Blob.create_and_upload!(
        io: File.open("#{Rails.root}/app/assets/images/6.jpg"),
        filename: "6.jpg"
      ),
      member_id: members[1].id,
      genre_id: genres[1].id 
    },
    {
      title: '初めての日',
      body: '今日は初めて歩きました！',
      image: ActiveStorage::Blob.create_and_upload!(
        io: File.open("#{Rails.root}/app/assets/images/4.jpg"),
        filename: "4.jpg"
      ),
      member_id: members[2].id,
      genre_id: genres[2].id 
    }
  ]
)














