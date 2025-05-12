class VideoMailer < ApplicationMailer
  def share_email
    @video = params[:video]
    mail(to: params[:email], subject: "Seu vídeo transcrito está pronto!")
  end
end
