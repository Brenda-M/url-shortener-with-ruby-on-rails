class StatsMailer < ApplicationMailer
  default from: 'SnappyUrl'

  def stats_email(user, urls_info)
    @user = user
    @urls_info = urls_info
    mail(to: @user.email, subject: '2-hour Analytics Insights')
  end
end
