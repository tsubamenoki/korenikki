class UsersController < ApplicationController

  def withdraw
    @user=current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

end
