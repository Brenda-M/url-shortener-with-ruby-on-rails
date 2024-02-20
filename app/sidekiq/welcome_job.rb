class WelcomeJob
  include Sidekiq::Job

  def perform(*args)
    user_id, username, email = args
    user = User.find(user_id)
    UserMailer.welcome_email(user, username, email).deliver_later
  end
end
