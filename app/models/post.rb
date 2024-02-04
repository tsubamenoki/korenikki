class Post < ApplicationRecord
  has_many_attached :post_images

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships

    validates :title, presence: true, length: { maximum: 20 }
    validates :body, presence: true, length: { maximum: 500 }
    validates :start_time, presence: true

  def save_tag(tags)
    #タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      #new_post_tagがself.tagsの末尾に代入
      self.tags << new_post_tag
    end
  end
end
