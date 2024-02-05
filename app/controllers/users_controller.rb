class UsersController < ApplicationController
  include Taggable
  include Postable
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_tags, only: [:edit, :confirm]
  before_action :set_calendar, only: [:edit, :update, :confirm]


  def edit
    @user = current_user
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
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:success] = "退会しました。またのご利用お待ちしています。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to root_path , notice: "ゲストユーザーはプロフィール画面に遷移できません。"
    end
  end
end
