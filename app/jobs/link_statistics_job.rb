class LinkStatisticsJob < ApplicationJob

  queue_as :default

  after_perform do |job|
    self.class.set(wait: 5.minutes).perform_later(job.arguments.first)
  end

  def perform(user_id)
    user = User.find(user_id)
    urls = user.urls.map { |url| {original_url: url.original_url, short_link: url.short_link, click: url.click } }
    StatsMailer.stats_email(user, urls).deliver_later
    self.class.set(wait: 5.minutes).perform_later(user.id)
  end
end
