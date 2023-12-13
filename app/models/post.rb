class Post < ApplicationRecord
  has_many_attached :image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships
  
  with_options presence: true, on: :publicize do
    validates :title
    validates :body
    validates :date
  end


  #タグの新規投稿メソッド
  def save_tags(tags)
    tags.each do |new_tags|
      self.tags.find_or_create_by(name: new_tags)
      #selfは@post
    end
  end

  #タグの更新メソッド
  def update_tags(latest_tags)
    if self.tags.empty?
      latest_tags.each do |latest_tag|
        self.tags.find_or_create_by(name: latest_tag)
      end
    elsif latest_tags.empty?
      self.tags.each do |tag|
        self.tags.delete(tag)
      end
    else
      current_tags = self.tags.pluck(:name)
      old_tags = current_tags - latest_tags
      new_tags = latest_tags - current_tags

      old_tags.each do |old_tag|
        tag = self.tags.find_by(name: old_tag)
        self.tags.delete(tag) if tag.present?
      end

      new_tags.each do |new_tag|
        self.tags.find_or_create_by(name: new_tag)
      end
    end
  end
end
