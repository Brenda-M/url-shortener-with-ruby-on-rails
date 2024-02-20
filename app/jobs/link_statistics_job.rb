class LinkStatisticsJob < ApplicationJob
  queue_as :default


  def perform(url_id)
    url = Url.find(url_id)
    user = url.user
    StatsMailer.stats_email(user, user.username, url).deliver_later

    self.class.set(wait_until: 2.hours.from_now).perform_later(url.id)
  end
end
