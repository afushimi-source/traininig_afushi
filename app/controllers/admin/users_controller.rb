class Admin::UsersController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.includes(:tasks).all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.search(params).sort_column(params).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = t 'users.flash.edit_success'
      redirect_to admin_users_path
    else
      flash.now[:danger] = @user.errors[:admin_none].first || t('users.flash.edit_error')
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = t 'users.flash.destroy_success'
      redirect_to admin_users_path
    else
      flash[:danger] = @user.errors[:admin_none].first || t('users.flash.destroy_error')
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def if_not_admin
    raise Unauthorized unless current_user.admin?
  end
end
