class RegistrationMailer < ApplicationMailer
    default from: 'rexwebcompany@gmail.com'
    layout 'mailer'

    def registration_email(event, registration)
        @event  = event
        @registration = registration
        mail(to: @registration.email, subject: 'Confirmação de inscrição')
    end
end
