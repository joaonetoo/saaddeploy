class RegistrationMailer < ApplicationMailer
    default from: 'sistema@saad.net.br'
    layout 'mailer'

    def registration_email(event, matriculation)
        @event  = event
        @matriculation = matriculation
        mail(to: @matriculation.email, subject: 'Confirmação de inscrição')
    end
end
