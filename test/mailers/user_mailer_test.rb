require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'welcome_email is enqueued' do
    user = User.create(username: 'JohnDoe', email: 'john.doe@example.com', password: '123test')
    user.save
    username = 'JohnDoe'
    email = 'john.doe@example.com'

    assert_enqueued_email_with(
      UserMailer,
      :welcome_email,
      args: [user, username, email]
    ) do
      UserMailer.welcome_email(user, username, email).deliver_later
    end
  end
end
