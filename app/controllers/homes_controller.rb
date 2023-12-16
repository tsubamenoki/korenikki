class HomesController < ApplicationController
  before_action :authenticate_user!, except: [:about]

  def top
    @post = Post.last
    @post_comment = PostComment.new
    @post_comments = PostComment.all
    @today_comment = @post_comments.created_today
    @yesterday_comment = @post_comments.created_yesterday
    @this_week_comment = @post_comments.created_this_week
    @last_week_commnet = @post_comments.created_last_week
  end
end
