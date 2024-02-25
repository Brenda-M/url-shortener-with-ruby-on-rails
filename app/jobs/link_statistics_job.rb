# class LinkStatisticsJob < ApplicationJob
#   queue_as :default

#   def perform(user_id)
#     user = User.find(user_id)
#     urls = user.urls.map { |url| { original_url: url.original_url, short_link: url.short_link, click: url.click } }
#     StatsMailer.stats_email(user, urls).deliver_later
#     reschedule_job(user.id)
#   end

#   private

#   def reschedule_job(user_id)
#     self.class.set(wait: 5.minutes).perform_later(user_id)
#   end
# end
#
# class LinkStatisticsJob < ApplicationJob
#   queue_as :default

#   def perform(user_id)
#     user = User.find(user_id)
#     urls = user.urls.map { |url| { original_url: url.original_url, short_link: url.short_link, click: url.click } }
#     StatsMailer.stats_email(user, urls).deliver_later
#     self.class.set(wait: 5.minutes).perform_later(user_id)
#   end
# end

class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    previous_urls = user.urls.map { |url| { id: url.id, click: url.click } }

    # Perform your statistics calculations and email sending here
    urls = user.urls.map { |url| { original_url: url.original_url, short_link: url.short_link, click: url.click } }
    StatsMailer.stats_email(user, urls).deliver_later

    # Check if a new URL is added or click count has increased
    reschedule_job(user.id) if urls_changed?(previous_urls, user.urls)
  end

  private

  def reschedule_job(user_id)
    self.class.set(wait: 5.minutes).perform_later(user_id)
  end

  def urls_changed?(previous_urls, current_urls)
    return true if current_urls.length > previous_urls.length

    current_urls.each do |url|
      previous_url = previous_urls.find { |prev_url| prev_url[:id] == url.id }
      return true if previous_url.nil? || url.click > previous_url[:click]
    end

    false
  end
end
