class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]

  def index
    @users = User.includes(:tasks).all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.search(params).sort_column(params).page(params[:page])
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
      redirect_to admin_path
    else
      flash.now[:danger] = t 'users.flash.edit_error'
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t 'users.flash.destroy_success'
    redirect_to admin_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
