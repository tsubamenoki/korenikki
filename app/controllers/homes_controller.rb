class HomesController < ApplicationController
  before_action :authenticate_user!, except: [:about]

  def top
    @post = current_user.posts.last
    unless @post == nil
      #コメント機能
      @post_comment = PostComment.new
      @post_comments = PostComment.all
      #コメントグラフ
      @today_comment = @post_comments.created_today
      @yesterday_comment = @post_comments.created_yesterday
      @this_week_comment = @post_comments.created_this_week
      @last_week_commnet = @post_comments.created_last_week
      #タグ関連
      @post_tags = @post.tags
      tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
      @tag_lists = Tag.where(id: tag_ids)
    end
  end
end
