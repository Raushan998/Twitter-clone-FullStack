require "test_helper"

class TweetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "it should not save the tweet" do
    tweet = Tweet.new(title: "Today is good day")
    assert_not tweet.save, "user_id is not present"
  end
end
