class UsersController < ApplicationController
  before_action :check_correct_user, only: %i[edit show update destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to tasks_url
      flash[:success] = t 'users.flash.create_success'
    else
      flash.now[:danger] = t 'users.flash.create_error'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = t 'users.flash.edit_success'
      redirect_to user_path(@user)
    else

      flash.now[:danger] = t 'users.flash.edit_error'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = t 'tasks.flash.destroy_success'
      redirect_to signup_path
    else
      flash[:danger] = @user.errors[:admin_none].first || t('tasks.flash.destroy_error')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_correct_user
    raise Forbidden unless correct_user?
  end

  def correct_user?
    user = User.find(params[:id])
    current_user && current_user == user
  end
end
