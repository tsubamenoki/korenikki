class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @post = current_user.posts

    if @range == "日付"
      @date = @post.where("date like?","%#{@word}%").page(params[:page])
    elsif @range == "タイトル"
      @title = @post.where("title like?","%#{@word}%").page(params[:page])
    elsif @range == "本文"
      @body = @post.where("body like?","%#{@word}%").page(params[:page])
    else
      post_ids = TagRelationship.where(tag_id: Tag.where("name like?","%#{@word}%")).pluck(:post_id)
      @tag = @post.where(id: post_ids).page(params[:page])
    end
  end
end
