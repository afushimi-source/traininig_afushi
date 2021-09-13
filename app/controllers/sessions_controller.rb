class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = t 'sessions.flash.creat_success'
    else
      flash.now[:error] = t 'sessions.flash.create_error'
      render 'new'
    end
  end

  def destroy
  end
end
