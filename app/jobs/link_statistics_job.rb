# app/jobs/link_statistics_job.rb

class LinkStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    urls = user.urls.map { |url| { original_url: url.original_url, short_link: url.short_link, click: url.click } }

    if should_send_email?(urls)
      StatsMailer.stats_email(user, urls).deliver_later
    end

    self.class.set(wait: 10.minutes).perform_later(user_id)
  end

  def self.scheduled_for_user?(user_id)
    enqueued_jobs = Sidekiq::ScheduledSet.new.select do |job|
      job.item["class"] == self.name && job.item["args"].first == user_id
    end

    enqueued_jobs.present?
  end

  private

  def should_send_email?(urls)
    urls.any? do |url|
      click_count = url[:last_known_click_count] || 0
      url[:click] > click_count || (url[:created_at]&. > 10.minutes.ago)
    end
  end
end
