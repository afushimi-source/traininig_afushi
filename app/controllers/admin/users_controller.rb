class Admin::UsersController < ApplicationController
  def index
    @users = User.eager_load(:tasks).page(params[:page])
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
    if @user.update(admin_user_params)
      flash[:success] = t 'users.flash.edit_success'
      redirect_to admin_path
    else
      flash.now[:danger] = t 'users.flash.edit_error'
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t 'users.flash.destroy_success'
    redirect_to admin_users_path
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
