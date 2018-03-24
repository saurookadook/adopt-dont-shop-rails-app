class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
