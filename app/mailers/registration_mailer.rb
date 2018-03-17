class RegistrationMailer < ApplicationMailer
    default from: 'sistema@saad.net.br'
    layout 'mailer'

    def registration_email(event, matriculation)
        @event  = event
        @matriculation = matriculation
        mail(to: @matriculation.email, subject: 'Confirmação de inscrição')
    end

    def send_certificate(matriculation,event)
       @event = event
       @matriculation = matriculation
       attachments.inline['background.pdf'] = File.read('background.pdf')
       mail(to: @matriculation.email, subject: 'Certificado De Participação')
	end
end
