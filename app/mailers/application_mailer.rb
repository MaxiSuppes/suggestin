class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@suggestin.co'

  def suggestion_notice(mail_address, message, sender_name, sender_email)
    @sender_email = sender_email
    @sender_name = sender_name
    @message = message
    mail(to: mail_address, subject: "Nueva queja o sugerencia en SuggestIn")
  end
end
