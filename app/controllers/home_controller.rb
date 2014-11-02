class HomeController < ApplicationController

  def index
  	if params.has_key? :pid
  		playlist = Playlist.find_or_initialize_by uri: params[:pid]
  	else
  		playlist = Playlist.new uri: new_playlist_uri
  	end
  	session[:pid] = playlist.uri
  end
end