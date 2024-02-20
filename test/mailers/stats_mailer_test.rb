# # test/mailers/stats_mailer_test.rb

# require 'test_helper'

# class StatsMailerTest < ActionMailer::TestCase
#   test 'stats_email is sent with correct subject and content' do
#     user = User.create(username: 'JohnDoe', email: 'john.doe@example.com')
#     url = Url.create(user: user)  # Adjust this based on your Url model attributes

#     email = StatsMailer.stats_email(user, 'JohnDoe', url)

#     assert_emails 1 do
#       email.deliver_now
#     end

#     assert_equal ['SnappyUrl@example.com'], email.from
#     assert_equal [user.email], email.to
#     assert_equal '2-hour Analytics Insights', email.subject

#     assert_includes email.html_part.body.to_s, user.username
#     assert_includes email.html_part.body.to_s, url.original_url
#     assert_includes email.html_part.body.to_s, url.short
#   end
# end
