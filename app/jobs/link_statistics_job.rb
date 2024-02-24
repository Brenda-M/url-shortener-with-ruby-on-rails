class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    urls = user.urls.map { |url| { original_url: url.original_url, short_link: url.short_link, click: url.click } }
    StatsMailer.stats_email(user, urls).deliver_later
    reschedule_job(user.id)
  end

  private

  def reschedule_job(user_id)
    self.class.set(wait: 5.minutes).perform_later(user_id)
  end
end
