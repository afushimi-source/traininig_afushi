class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
      flash[:success] = t 'sessions.flash.creat_success'
    else
      flash.now[:error] = t 'sessions.flash.create_error'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
