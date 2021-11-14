class Tweet < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
    validates :title, length: {minimum: 5, maximum: 280}
end
