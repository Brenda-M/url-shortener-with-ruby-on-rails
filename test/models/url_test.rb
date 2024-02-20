require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  setup do
    @user = User.new(username: "user1", email: "user1@example.com", password: "password123")
    @url = Url.new(user: @user, original_url: "https://example.com")
  end

  test "url should be valid" do
    assert @url.valid?
  end

  test "original_url should not be blank" do
    @url.original_url = ""
    assert_not @url.valid?
    assert_equal ["Enter a valid URL", "Not a valid URL"], @url.errors[:original_url]
  end

  test "original_url should have a valid format" do
    invalid_urls = ["invalid-url", "ftp://example.com"]
    invalid_urls.each do |url|
      @url.original_url = url
      assert_not @url.valid?
      assert_equal ["Not a valid URL"], @url.errors[:original_url]
    end
  end

  test "generate_short_url should set a non-empty short_url" do
    @url.short_url = nil
    @url.send(:generate_short_url)
    assert_not_nil @url.short_url
    assert_not_empty @url.short_url
  end

  test "should destroy url" do
    url = Url.create(user: @user)

    assert_difference('Url.count', -1) do
      delete :destroy, params: { id: url.id }
    end

    assert_redirected_to show_urls_path
    assert_equal 'URL was successfully deleted.', flash[:notice]
  end

  test "should redirect to original_url" do
    url = Url.create(user: @user, original_url: "https://example.com", short_url: "abc123")

    get :redirect, params: { short_url: url.short_url }

    assert_redirected_to url.original_url
    assert_equal 1, url.reload.click
  end

end
