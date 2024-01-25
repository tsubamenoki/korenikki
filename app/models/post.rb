class Post < ApplicationRecord
  has_many_attached :post_images

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships

    validates :title, presence: true, length: { maximum: 20 }
    validates :body, presence: true, length: { maximum: 500 }
    validates :date, presence: true

  #投稿画像のメソッド
  def get_post_image
    #byebug
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_yoko.jpg')
      image.attached(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_images
  end

  #タグの新規投稿メソッド
  def save_tags(tags)
    tags.each do |new_tags|
      save_tag(new_tags)
    end
  end

  def save_tag(new_tags)
    tag = Tag.find_or_create_by(name: new_tags)
    self.tag_relationships.create(post_id: self.id, tag_id: tag.id)
  end

  #タグの更新メソッド
  def update_tags(latest_tags)
    if self.tags.empty?
      latest_tags.each do |latest_tag|
        save_tag(latest_tag)
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
        save_tag(new_tag)
      end
    end
  end
end
