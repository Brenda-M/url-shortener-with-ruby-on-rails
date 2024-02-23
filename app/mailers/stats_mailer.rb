# class StatsMailer < ApplicationMailer
#   default from: 'SnappyUrl'

#   def stats_email(user, username, url)
#     @user = user
#     @url = url
#     @username = username
#     mail(to: @user.email, subject: '2-hour Analytics Insights')
#   end
# end

class StatsMailer < ApplicationMailer
  def stats_email(user, username, urls)
    @user = user
    @username = username
    @urls = urls

    mail(to: user.email, subject: 'URL Statistics')
  end
end
