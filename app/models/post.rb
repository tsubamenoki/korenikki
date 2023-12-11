class Post < ApplicationRecord
  has_many_attached :image

  belongs_to :user
  has_many :post_comments

end
