class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]


  def edit
    @user = current_user
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
  end

  def update
    @user = current_user
    if @user.profile_image.attached?
      @user.profile_image.purge
    end
    if @user.update(user_params)
      flash[:success] = "変更しました"
      redirect_to top_path
    else
      flash.now[:danger] = "変更に失敗しました"
      render :edit
    end
  end

  def confirm
    @user = current_user
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:success] = "退会しました。またのご利用お待ちしています。"
    redirect_to root_path
    tag_ids = TagRelationship.where(post_id: current_user.posts.pluck(:id)).pluck(:tag_id)
    @tag_lists = Tag.where(id: tag_ids)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :password)
  end

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to root_path , notice: "ゲストユーザーはプロフィール画面に遷移できません。"
    end
  end

end
