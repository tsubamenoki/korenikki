class PostsController < ApplicationController
  include Taggable
  include Postable
  before_action :authenticate_user!
  before_action :is_match_login_user, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:new, :show, :index, :edit, :search_tag]
  before_action :set_calendar, only: [:new, :create, :show, :index, :edit, :update, :search_tag]

  def new
    @post = Post.new
    @posts = current_user.posts
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tags = params[:post][:tag_name].split(',')
    if @post.save
     @post.save_tag(tags)
     flash[:success] = "投稿に成功しました"
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page])
    @tag_list = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tags = params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tag(tags)
      flash[:success] = "変更しました"
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "変更に失敗しました"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:success] = "削除しました"
    redirect_to posts_path
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.order(created_at: :desc).where(user_id: current_user.id).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :start_time, post_images: [])
  end

  def is_match_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      flash[:danger] = "他の人の投稿は閲覧できません"
      redirect_to top_path
    end
  end
end
