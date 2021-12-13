module TweetsHelper
    def username(tweet)
        tweet.user.username unless tweet.user.blank? and tweet.user.username.blank?
    end
end
