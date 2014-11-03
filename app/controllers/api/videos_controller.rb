module Api
	class VideosController < ApplicationController
		respond_to :json

		def index
			playlist = current_playlist
			respond_with [!playlist.new_record?, playlist.videos]
		end

		def create
			video = Video.new video_params
			playlist = current_playlist
			playlist.videos << video if video.valid?
			playlist.save
			respond_with video, location: ''
		end

		def sync
			videos = params[:videos]
			playlist = current_playlist
			videos.each do |video|
				video.delete "inqueue" if video.has_key? "inqueue"
				video.delete "deleted" if video.has_key? "deleted"
				tmp = Video.new video
				playlist.videos << Video.new(video) if tmp.valid?
			end

			if playlist.save
				respond_with [playlist.uri], location: ''
			else
				respond_with [], location: ''
			end
		end

		def destroy
			playlist = current_playlist
			video = playlist.videos.where vid: params[:id]
			video.delete if video.count == 1
			respond_with [], location: ''
		end

		private

		def video_params
			params.permit :vid, :title, :thumbnail, :duration
		end
	end
end