class StatisticsJob
  include Sidekiq::Job

  def perform(url_id)
    url = Url.find(url_id)
    user = url.user
    StatsMailer.stats_email(user, user.username, url).deliver_later
  end
end
