# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

guestuser = User.find_or_create_by!(email: "guest@example.com") do |guest|
  guest.name = "guestuser"
  guest.password = SecureRandom.urlsafe_base64
end

Post.find_or_create_by!(title: "【作成見本】野球いいですね") do |post|
  post.post_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "今日は野球観戦をしてきました。試合前のノックのうまさに恍惚としました。"
  post.start_time = "2024-01-01T09:00"
  post.user = guestuser
end

Post.find_or_create_by!(title: "【作成見本】なんだこいつ") do |post|
  post.post_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "沖縄旅行中謎の魚に遭遇。新種なのかも知れない。"
  post.start_time = "2024-01-01T09:00"
  post.user = guestuser
end

Post.find_or_create_by!(title: "【作成見本】本年もよろしくお願いします。") do |post|
  post.post_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = "今日から辰年！そして本厄！何も起きないでください！"
  post.start_time = "2024-01-01T09:00"
  post.user = guestuser
end