class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
      flash[:success] = t 'sessions.flash.create_success'
    else
      flash.now[:danger] = t 'sessions.flash.create_error'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
    flash[:success] = t 'sessions.flash.destroy_success'

  end
end
