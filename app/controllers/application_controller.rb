class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :current_user_playlists, :require_login
  include PublicActivity::StoreController

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user == nil
  end

  def current_user_playlists
    Playlist.where(user: current_user)
  end

  def require_login
    redirect_to login_path unless session.include? :user_id
  end

end
