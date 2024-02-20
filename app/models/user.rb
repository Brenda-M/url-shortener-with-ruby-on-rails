class User < ApplicationRecord
  has_many :urls, dependent: :destroy

  before_save :downcase

  has_secure_password

  validates :username,
            presence: {
              message: "can't be blank",
            },
            uniqueness: {
              message: 'is already taken',
            }
  validates :email,
            presence: {
              message: "can't be blank",
            },
            uniqueness: {
              message: 'is already taken',
            }
  validates_format_of :email,
                      with: URI::MailTo::EMAIL_REGEXP,
                      message: 'Invalid email format'

  HUMANIZED_ATTRIBUTES = {
    username: 'Username',
    email: 'Email',
    password_digest: 'Password',
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def downcase
    self.email = email.downcase
    self.username = username.downcase
  end

end
