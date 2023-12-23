class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    unless @post_comment.save
      flash.now[:danger] = "投稿しました"
      render 'error'
    end
    @new_post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
  end
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end