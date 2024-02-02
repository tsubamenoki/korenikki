class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_match_login_user, only: [:show, :edit, :update, :destroy]


  def new
    @post = Post.new
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
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
    @tags = @post.tags.pluck(:name).join(',')
    @post_tags = @post.tags
    @post_comment = PostComment.new
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
  end

  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page])
    @tag_list = Tag.all
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
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
    @tag = Tag.find(params[:tag_name])
    @posts = @tag.posts.order(created_at: :desc).where(user_id: current_user.id).page(params[:page])
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
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
