class UserMailer < ApplicationMailer
  def welcome(email, name)
    return if email.blank?

    @name = name
    mail to: email, subject: I18n.t('emails.subjects.welcome')
  end
end
