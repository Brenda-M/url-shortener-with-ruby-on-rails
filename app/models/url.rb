class Url < ApplicationRecord
  belongs_to :user

  before_validation :generate_short_url
  # before_save :update_last_known_click_count

  validates :original_url, presence: { message: "Enter a valid link" }, format: { with: URI::regexp(%w[http https]), message: "Not a valid URL" }
  validates :short_url, uniqueness: { message: "is already taken" }, length: { maximum: 8, message: "is too long (maximum is 8 characters)" }

  HUMANIZED_ATTRIBUTES = {
    original_url: "",
    short_url: "Alias"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def short_link
    Rails.application.routes.url_helpers.short_link_url(self.short_url, host: 'http://localhost:3000')
  end

  def generate_short_url
    self.short_url = SecureRandom.hex(4) if self.short_url.nil? || self.short_url.empty?
  end

  # def update_last_known_click_count
  #   self.last_known_click_count = click_changed? ? click_was : click
  # end
end
