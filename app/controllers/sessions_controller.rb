class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if !params[:provider].nil?
      @user = User.update_or_create(auth)
    else
      @user = User.find_by(username: user_params[:username])
    end

    if @user.authenticate(user_params[:password])
      set_session(@user.id)
      flash[:message] = "Successfully logged in!"
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    session.delete :user_id if !session[:user_id].nil?
    redirect_to :root
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
