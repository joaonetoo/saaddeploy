class UserMailer < ApplicationMailer
    default from: 'sistema@saad.net.br'
    layout 'mailer'

    def sample_email(email, mensagem, doc, autor)
        @email  = email
        @mensagem = mensagem
        @autor = autor
        attachments["feedback_#{Date.today.iso8601}.doc"] = {
            mime_type: 'application/msword',
            content: open(doc).read
        }
        mail(to: @email, subject: 'Feedback trabalho')
    end




end
