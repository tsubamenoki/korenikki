class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @post = current_user.posts

    if @range == "日付"
      @date = @post.order(created_at: :desc).where("date like?","%#{@word}%").page(params[:page])
    elsif @range == "タイトル"
      @title = @post.order(created_at: :desc).where("title like?","%#{@word}%").page(params[:page])
    elsif @range == "本文"
      @body = @post.order(created_at: :desc).where("body like?","%#{@word}%").page(params[:page])
    else
      post_ids = TagRelationship.where(tag_id: Tag.where("name like?","%#{@word}%")).pluck(:post_id)
      @tag = @post.order(created_at: :desc).where(id: post_ids).page(params[:page])
    end

    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.order(created_at: :desc).where(id: tag_ids)
  end
end
