module Postable
  extend ActiveSupport::Concern

  def set_calendar
    @posts = current_user.posts.all
  end
end