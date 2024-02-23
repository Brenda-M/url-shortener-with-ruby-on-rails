class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    urls = user.urls.map { |url| url.short_link }

    # Send email with all generated URLs
    StatsMailer.stats_email(user, user.username, urls).deliver_later

    # Reschedule the job for 2 hours later
    self.class.set(wait: 5.minutes).perform_later(user.id)
  end
end
