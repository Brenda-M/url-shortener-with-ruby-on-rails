class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)

    return unless user

    user_urls = user.urls.to_a
    last_run_count = user.last_known_url_count || 0

    send_email_if_not_sent(user, user_urls, last_run_count)
    update_last_known_click_count(user_urls)
    update_last_known_url_count(user)

    self.class.set(wait: 2.hours).perform_later(user_id)
  end

  private

  def send_email_if_not_sent(user, urls, last_run_count)
    if urls.any? { |url| url.last_known_click_count.nil? || click_increased?(url) } || urls.count > last_run_count
      StatsMailer.stats_email(user, urls).deliver_later
    end
  end

  def click_increased?(url)
    url.click.to_i > url.last_known_click_count.to_i
  end

  def update_last_known_click_count(urls)
    urls.each { |url| url.update_column(:last_known_click_count, url.click) }
  end

  def update_last_known_url_count(user)
    user.update_column(:last_known_url_count, user.urls.count)
  end
end
