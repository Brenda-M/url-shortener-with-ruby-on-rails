class StatsMailer < ApplicationMailer
  default from: 'SnappyUrl'

  def stats_email(user, username, url)
    @user = user
    @url = url
    @username = username
    mail(to: @user.email, subject: '2-hour Analytics Insights')
  end
end
