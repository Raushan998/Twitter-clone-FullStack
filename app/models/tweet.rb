class Tweet < ApplicationRecord
    has_one_attached :avatar
    has_one_attached :profile_video
    belongs_to :user
    has_many :comments
    has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
    validates :title, presence: true, length: {minimum: 5, maximum: 280}
    after_save :set_video

    private
    def set_video
        unless self.profile_video.blank?
            # update_conversion_value
            Resque.enqueue(Workers::ConvertVideo, self.id)
        end
    end

    def update_conversion_value
        return unless self.profile_video
        needs_conversion = self.profile_video.content_type != "video/mp4"
        self.update_column(:convert_video, :profile_video)
    end
end
