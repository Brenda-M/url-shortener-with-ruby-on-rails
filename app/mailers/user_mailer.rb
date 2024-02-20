class UserMailer < ApplicationMailer
  default from: 'SnappyUrl'

  def welcome_email(user, username, email)
    @user = user
    @username = username
    @greeting = "Hi, #{@username}"

    mail(to: email, subject: '🌟 Welcome to SnappyUrl 🌟')
  end
end

