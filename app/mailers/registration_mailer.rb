class RegistrationMailer < ApplicationMailer
    default from: 'rexwebcompany@gmail.com'
    layout 'mailer'

    def registration_email(event, matriculation)
        @event  = event
        @matriculation = matriculation
        mail(to: @matriculation.email, subject: 'Confirmação de inscrição')
    end
end
