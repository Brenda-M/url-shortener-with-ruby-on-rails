
class StatsMailer < ApplicationMailer
  default from: 'SnappyUrl'

  def stats_email(user, urls)
    @user = user
    @urls = urls
    mail(to: @user.email, subject: '2-hour Analytics Insights')
  end
end
