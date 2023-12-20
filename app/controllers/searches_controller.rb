class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "日付"
      @date = current_user.posts.where("date like?","%#{@word}%")
    elsif @range == "タイトル"
      @title = current_user.posts.where("title like?","%#{@word}%")
    elsif @range == "本文"
      @body = current_user.posts.where("body like?","%#{@word}%")
    else
      @tag = current_user.tags.where("name like?","%#{@word}%")
    end
  end
end
