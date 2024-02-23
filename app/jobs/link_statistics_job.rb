# class LinkStatisticsJob < ApplicationJob
#   queue_as :default


#   def perform(url_id)
#     url = Url.find(url_id)
#     user = url.user
#     StatsMailer.stats_email(user, user.username, url).deliver_later

#     self.class.set(wait_until: 2.hours.from_now).perform_later(url.id)
#   end
# end

class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    urls = user.urls
    StatsMailer.stats_email(user, user.username, urls).deliver_later

    # Reschedule the job for the next run
    self.class.set(wait_until: 2.hours.from_now).perform_later(user.id)
  end
end
