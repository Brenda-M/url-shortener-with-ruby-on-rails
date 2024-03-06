


# class LinkStatisticsJob < ApplicationJob
#   queue_as :default

#   def perform(user_id)
#     user = User.find_by(id: user_id)

#     return unless user

#     user.urls.each do |url|
#       send_email_if_not_sent(user, url)
#       update_last_known_click_count(url)
#     end

#     self.class.set(wait: 3.minutes).perform_later(user_id)
#   end

#   private

#   def send_email_if_not_sent(user, url)
#     if url.last_known_click_count.nil?
#       StatsMailer.stats_email(user, [url]).deliver_later
#     elsif click_increased?(url)
#       StatsMailer.stats_email(user, [url]).deliver_later
#     end
#   end

#   def click_increased?(url)
#     url.click.to_i > url.last_known_click_count.to_i
#   end

#   def update_last_known_click_count(url)
#     url.update_column(:last_known_click_count, url.click)
#   end
# end


# app/jobs/link_statistics_job.rb
class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)

    return unless user

    user_urls = user.urls.to_a

    send_email_if_not_sent(user, user_urls)
    update_last_known_click_count(user_urls)

    self.class.set(wait: 3.minutes).perform_later(user_id)
  end

  private

  def send_email_if_not_sent(user, urls)
    if urls.any? { |url| url.last_known_click_count.nil? || click_increased?(url) }
      StatsMailer.stats_email(user, urls).deliver_later
    end
  end

  def click_increased?(url)
    url.click.to_i > url.last_known_click_count.to_i
  end

  def update_last_known_click_count(urls)
    urls.each { |url| url.update_column(:last_known_click_count, url.click) }
  end
end
