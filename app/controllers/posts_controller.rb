class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_match_login_user, only: [:show, :edit, :update, :destroy]


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tags = params[:post][:tag_id].split(',')
    if @post.save
     @post.save_tags(tags)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def index
    @posts = current_user.posts
    @tag_list = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tags = params[:post][:tag_id].split(',')
    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :date, post_images: [])
  end

  def is_match_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to root_path
    end
  end
end
