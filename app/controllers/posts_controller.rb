class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tags = params[:post][:tag_name].split(',')
    #投稿ボタン
    if params[:post]
      if @post.save(context: :publicize)
        @post.save_tags(tags)
        redirect_to post_path(@post)
      else
        render :new
      end
    else
      #一時保存ボタン
      if @post.update(is_draft: true)
        redirect_to post_path
      else render :new
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tags = params[:post][:tag_name].split(',')
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

  private

  def post_params
    params.require(:post).permit(:title, :body, :date, image: [])
  end
end
