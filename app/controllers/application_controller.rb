class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_playlist
  	@xplaylist ||= Playlist.find_or_initialize_by uri: session[:pid] if session[:pid]
  end

  def new_playlist_uri
  	rand(36**8).to_s(36)
  end
end
