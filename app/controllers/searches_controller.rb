class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "日付"
      @date = Post.where("date like?","%#{@word}%")
    elsif @range == "タイトル"
      @title = Post.where("title like?","%#{@word}%")
    elsif @range == "本文"
      @body = Post.where("body like?","%#{@word}%")
    else
      @tag = Tag.where("name like?","%#{@word}%")
    end
  end
end
