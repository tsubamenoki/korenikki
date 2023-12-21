class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @post = current_user.posts

    if @range == "日付"
      @date = @post.where("date like?","%#{@word}%")
    elsif @range == "タイトル"
      @title = @post.where("title like?","%#{@word}%")
    elsif @range == "本文"
      @body = @post.where("body like?","%#{@word}%")
    else
      @tag = Tag.where("name like?","%#{@word}%")

    end
  end
end
