class ShareJob < ApplicationJob
  queue_as :default

  def perform(video_id, email)
    video = Video.find(video_id)

    # Envia email com link para download
    VideoMailer.with(video: video, email: email).share_email.deliver_now

    # Futuramente podemos adicionar integração com Google Drive aqui
  end
end
