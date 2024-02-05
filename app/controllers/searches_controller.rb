class SearchesController < ApplicationController
  include Taggable
  include Postable
  before_action :authenticate_user!
  before_action :set_tags, only: [:search]
  before_action :set_calendar, only: [:search]

  def search
    @range = params[:range]
    @word = params[:word]
    @post = current_user.posts

    if @range == "日付"
      @date = @post.order(start_time: :desc).where("start_time like?","%#{@word}%").page(params[:page])
    elsif @range == "タイトル"
      @title = @post.order(start_time: :desc).where("title like?","%#{@word}%").page(params[:page])
    elsif @range == "本文"
      @body = @post.order(start_time: :desc).where("body like?","%#{@word}%").page(params[:page])
    else
      post_ids = TagRelationship.where(tag_id: Tag.where("name like?","%#{@word}%")).pluck(:post_id)
      @tag = @post.order(start_time: :desc).where(id: post_ids).page(params[:page])
    end
  end
end
