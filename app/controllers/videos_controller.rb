class VideosController < ApplicationController
  # POST /videos

  def index
     @videos = Video.all.with_attached_file

    render json: @videos.map { |video|
      {
        id: video.id,
        title: video.title,
        file_url: video.file.attached? ? url_for(video.file) : nil
        
      }
      
    }
  end

  def create
    @video = Video.new(title: params[:title])
    @video.file.attach(params[:file])

    if @video.save
      render json: { message: "Video uploaded!", id: @video.id }, status: :created
    else
      render json: { errors: @video.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /videos/:id/share
  def share
    video = Video.find(params[:id])
    email = params[:email]
    ShareJob.perform_later(video.id, email)
    render json: { message: "Compartilhamento iniciado" }
  end

  private

  def video_params
    params.permit(:title)
  end
end
