class TranscribeJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find(video_id)

    # Simula chamada para Whisper API (aqui poderia ser HuggingFace ou Replicate)
    response = HTTParty.post("https://api.whisper.fake/transcribe", body: {
      audio_url: Rails.application.routes.url_helpers.rails_blob_url(video.file, only_path: false)
    })

    # Aqui simula uma transcrição fictícia
    transcript = "Transcrição gerada para o vídeo ID #{video.id}"

    video.update(transcript: transcript)
  end
end
