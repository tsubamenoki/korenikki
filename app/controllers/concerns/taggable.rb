module Taggable
  extend ActiveSupport::Concern

  def set_tags
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
  end
end