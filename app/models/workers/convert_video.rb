module Workers
    class ConvertVideo
        @queue = :video_queue

        def self.perform user_id
            video = Services::VideoConverter.new(user_id)
            video.convert!
        end
    end
end